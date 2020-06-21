#ifndef ANSWERAREAMODEL_H
#define ANSWERAREAMODEL_H

#include <QObject>

#include "scoreboardmodel.h"

class AnswerAreaModel : public ScoreboardModel
{
    Q_OBJECT
public:
    AnswerAreaModel(int rows, int columns, QObject* parent = nullptr) : ScoreboardModel(rows, columns, parent) {
        m_maxAnswerLength = columnCount() - (4 /* spaces */ + 1 /* digit */ + s_scorePlaceholder.length());
        qDebug() << "Max answer length is " << m_maxAnswerLength << Qt::endl;
    };

    Q_INVOKABLE void prepareForQuestion(int answerCount);
    Q_INVOKABLE void printSum();
    Q_INVOKABLE void printAnswer(int answerNo, QString answerText, int answerPoints);
    Q_INVOKABLE void clearAnswer(int answerNo, int answerPoints);

private:
    void printAnswerPlaceholder(int answerNo);

    inline int topRowOffset() const noexcept {
        return 1 + static_cast<int>(m_answerCount < 6);
    }

    static inline const QChar s_ellipsis = u'…';
    static inline const QString s_sumKeyword = "SUMA";
    static inline const QString s_scorePlaceholder = "━━";

    int m_maxAnswerLength;
    int m_answerCount = 6;
    int m_sum = 0;
};

#endif // ANSWERAREAMODEL_H
