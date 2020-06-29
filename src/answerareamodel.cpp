#include "answerareamodel.h"

#include <chrono>

using namespace std::chrono_literals;

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
    m_timers.clear();
    m_timers.resize(m_answerCount);
}

void AnswerAreaModel::printSum() {
    int row = topRowOffset() + m_answerCount + 1;
    int column = columnCount() - 1 - 3 /* sum digits */ - 1 - s_sumKeyword.length();
    QString sumText = s_sumKeyword + " "+ QString::number(m_sum).rightJustified(3) + " ";
    display(sumText, row, column);
}

void AnswerAreaModel::printAnswer(int answerNo, QString answerText, int answerPoints)
{
    if (m_timers.at(answerNo)) {
        return; // this answer is already on the timer, so nothing to do
    }
    if (answerText.length() > m_maxAnswerLength) {
        m_timers[answerNo] = std::make_unique<QTimer>();
        auto& timer = m_timers[answerNo];
        int offset = 0;
        bool isGoingRight = true;
        timer->callOnTimeout([this, &timer, answerNo, answerText, offset, isGoingRight]() mutable {
            const auto maxOffset = answerText.length() - m_maxAnswerLength;
            const auto goingRightInterval = 300ms;
            const auto goingLeftInterval = 100ms;
            const auto leftEndpointDelay = 2s;
            const auto rightEndpointDelay = 1s;
            if (timer->intervalAsDuration() == rightEndpointDelay) {
                timer->setInterval(goingLeftInterval);
            } else  if (timer->intervalAsDuration() == leftEndpointDelay) {
                timer->setInterval(goingRightInterval);
            }
            if (offset == 0) {
                isGoingRight = true;
                timer->setInterval(leftEndpointDelay);
            } else if (offset == maxOffset) {
                isGoingRight = false;
                timer->setInterval(rightEndpointDelay);
            }
            auto movedText = answerText.mid(offset, m_maxAnswerLength);
            printAnswerText(answerNo, movedText);
            offset = isGoingRight? offset + 1 : offset - 1;
        });
        timer->start(200);
    }
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
    m_timers[answerNo] = nullptr;
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

void AnswerAreaModel::printAnswerText(int answerNo, QString text)
{
    if (text.length() != m_maxAnswerLength) {
        text.resize(m_maxAnswerLength, ' ');
    }
    auto columnOffset = 3; // single digit + surrounding spaces
    display(text, topRowOffset() + answerNo, columnOffset);
}
