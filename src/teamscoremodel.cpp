#include "teamscoremodel.h"


void TeamScoreModel::displayScore()
{
    auto text = QString::number(m_score).rightJustified(columnCount());
    display(text);
}
