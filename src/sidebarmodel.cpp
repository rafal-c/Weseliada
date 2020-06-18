#include "sidebarmodel.h"

const QString SidebarModel::smallXchars = "▚ ▞ ⌛ ▞ ▚";
const QString SidebarModel::bigXchars = "▙ ▟▜ ▛ ⌛ ▟ ▙▛ ▜";


void SidebarModel::displayBigX()
{
    display(bigXchars, 3, 0);
}

void SidebarModel::displaySmallX()
{
    if (m_smallXCount == 0) {
        clear();
        display(smallXchars, 7, 0);
        m_smallXCount++;
    } else if (m_smallXCount == 1){
        display(smallXchars, 4, 0);
        m_smallXCount++;
    } else if (m_smallXCount == 2){
        display(smallXchars, 1, 0);
        m_smallXCount++;
    }
}

void SidebarModel::clear()
{
    ScoreboardModel::clear();
    m_smallXCount = 0;
}
