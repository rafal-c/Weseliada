#include "answerareamodel.h"

void AnswerAreaModel::prepareForQuestion(int answerCount)
{
    clear();
    m_answerCount = answerCount;
    for (int i = 1; i <= answerCount; ++i) {
        printAnswerPlaceholder(i);
        printSum(0);

    }
}

void AnswerAreaModel::printSum(int sum) {
    int row = topRowOffset() + m_answerCount + 1;
    int column = columnCount() - 1 - 3 /* sum digits */ - 1 - s_sumKeyword.length();
    QString sumText = s_sumKeyword + " "+ QString::number(sum).rightJustified(3) + " ";
    display(sumText, row, column);
}

void AnswerAreaModel::printAnswerPlaceholder(int answerNo)
{
    int ellipsisLength = columnCount() - (4 /* spaces */ + 1 /* digit */ + s_scorePlaceholder.length());
    QString placeholderText = " " + QString::number(answerNo) + " " + QString(ellipsisLength, s_ellipsis) + " " + s_scorePlaceholder + " ";
    display(placeholderText, topRowOffset() + answerNo - 1, 0);
}
