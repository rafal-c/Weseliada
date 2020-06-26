#ifndef TEAMSCOREMODEL_H
#define TEAMSCOREMODEL_H

#include "scoreboardmodel.h"

class TeamScoreModel : public ScoreboardModel
{
    Q_OBJECT

public:
    explicit TeamScoreModel(int digitCount = 3, QObject *parent = nullptr) : ScoreboardModel(1, digitCount, parent) {}

    Q_INVOKABLE void displayScore();

    void addPoints(int points) {
        m_score += points;
        displayScore();
    }
private:
    int m_score = 0;
};

#endif // TEAMSCOREMODEL_H
