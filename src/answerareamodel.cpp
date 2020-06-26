#include "answerareamodel.h"

void AnswerAreaModel::prepareForQuestion(int answerCount)
{
    clear();
    m_answerCount = answerCount;
    for (int i = 0; i < answerCount; ++i) {
        printAnswerPlaceholder(i);
    }
    m_pointsAssigned = false;
    m_sum = 0;
    printSum();
}

void AnswerAreaModel::printSum() {
    int row = topRowOffset() + m_answerCount + 1;
    int column = columnCount() - 1 - 3 /* sum digits */ - 1 - s_sumKeyword.length();
    QString sumText = s_sumKeyword + " "+ QString::number(m_sum).rightJustified(3) + " ";
    display(sumText, row, column);
}

void AnswerAreaModel::printAnswer(int answerNo, QString answerText, int answerPoints)
{
    answerText.resize(m_maxAnswerLength, ' ');
    QString text = " " + QString::number(answerNo + 1) + " " + answerText + " " + QString::number(answerPoints).rightJustified(2) + " ";
    display(text, topRowOffset() + answerNo, 0);
    if(!m_pointsAssigned) {
        m_sum += answerPoints;
        printSum();
    }
}

void AnswerAreaModel::clearAnswer(int answerNo, int answerPoints)
{
    printAnswerPlaceholder(answerNo);
    m_sum -= answerPoints;
    printSum();
}

void AnswerAreaModel::assignPoints(int teamIndex)
{
    if (teamIndex < 0 || static_cast<std::size_t>(teamIndex) >= teams.size()) {
        return;
    }
    teams[teamIndex]->addPoints(m_sum);
    m_pointsAssigned = true;
}

void AnswerAreaModel::printAnswerPlaceholder(int answerNo)
{
    QString placeholderText = " " + QString::number(answerNo + 1) + " " + QString(m_maxAnswerLength, s_ellipsis) + " " + s_scorePlaceholder + " ";
    display(placeholderText, topRowOffset() + answerNo, 0);
}
