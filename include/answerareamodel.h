#ifndef ANSWERAREAMODEL_H
#define ANSWERAREAMODEL_H

#include <QObject>

#include "scoreboardmodel.h"

class AnswerAreaModel : public ScoreboardModel
{
    Q_OBJECT
public:
    using ScoreboardModel::ScoreboardModel;
    explicit AnswerAreaModel(QObject *parent = nullptr) : AnswerAreaModel(10, 24, parent) {};

    Q_INVOKABLE void prepareForQuestion(int answerCount);
    Q_INVOKABLE void printSum(int sum);

private:
    void printAnswerPlaceholder(int anserNo);

    inline int topRowOffset() const noexcept {
        return 1 + static_cast<int>(m_answerCount < 6);
    }

    static inline const QChar s_ellipsis = u'…';
    static inline const QString s_sumKeyword = "SUMA";
    static inline const QString s_scorePlaceholder = "━━";

    int m_answerCount = 6;
};

#endif // ANSWERAREAMODEL_H
