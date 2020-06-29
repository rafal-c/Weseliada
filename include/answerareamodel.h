#ifndef ANSWERAREAMODEL_H
#define ANSWERAREAMODEL_H

#include <memory>
#include <vector>

#include <QObject>
#include <QTimer>

#include "scoreboardmodel.h"
#include "teamscoremodel.h"

class QTimer;

enum class Team {
    Left = 0,
    Right
};

class AnswerAreaModel : public ScoreboardModel
{
    Q_OBJECT
public:
    AnswerAreaModel(int rows, int columns, QObject* parent = nullptr) : ScoreboardModel(rows, columns, parent) {
        for (auto& teamModel : teams) {
            teamModel = std::make_unique<TeamScoreModel>(3);
            teamModel->display("  0");
        }
        m_maxAnswerLength = columnCount() - (4 /* spaces */ + 1 /* digit */ + s_scorePlaceholder.length());
    };

    Q_INVOKABLE void prepareForQuestion(int answerCount);
    Q_INVOKABLE void printSum();
    Q_INVOKABLE void printAnswer(int answerNo, QString answerText, int answerPoints);
    Q_INVOKABLE void clearAnswer(int answerNo, int answerPoints);

    Q_INVOKABLE void assignPoints(int teamIndex);


    TeamScoreModel* getTeamModel(Team index) {
        return teams[static_cast<std::size_t>(index)].get();
    }

private:
    void printAnswerPlaceholder(int answerNo);

    void printAnswerText(int answerNo, QString text);

    inline int topRowOffset() const noexcept {
        return 1 + static_cast<int>(m_answerCount < 6);
    }

    static inline const QChar s_ellipsis = u'…';
    static inline const QString s_sumKeyword = "SUMA";
    static inline const QString s_scorePlaceholder = "━━";

    std::array<std::unique_ptr<TeamScoreModel>, 2> teams;

    bool m_pointsAssigned = false;
    int m_maxAnswerLength;
    int m_answerCount = 6;
    int m_sum = 0;
    std::vector<std::unique_ptr<QTimer>> m_timers;
};

#endif // ANSWERAREAMODEL_H
