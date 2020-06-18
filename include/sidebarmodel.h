#ifndef SIDEBAR_H
#define SIDEBAR_H

#include <QObject>

#include "scoreboardmodel.h"

class SidebarModel : public ScoreboardModel
{
    Q_OBJECT
public:
    using ScoreboardModel::ScoreboardModel;
    explicit SidebarModel(QObject *parent = nullptr) : SidebarModel(10, 3, parent) {};

    Q_INVOKABLE void displayBigX();
    Q_INVOKABLE void displaySmallX();
    void clear() override;

private:
    static const QString smallXchars;
    static const QString bigXchars;

    int m_smallXCount = 0;

};

#endif // SIDEBAR_H
