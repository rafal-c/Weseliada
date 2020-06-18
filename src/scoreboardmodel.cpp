#include "scoreboardmodel.h"

#include <algorithm>

ScoreboardModel::ScoreboardModel(int rows, int columns, QObject *parent)
    : QAbstractTableModel(parent), m_rows(rows), m_columns(columns), m_board(rows * columns)
{
    qDebug() << QString("ScoreboardModel created with %1 rows and %2 columns").arg(m_rows).arg(m_columns) << Qt::endl;
}

int ScoreboardModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_rows;
}

int ScoreboardModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_columns;
}

QVariant ScoreboardModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != TextRole)
        return QVariant();
    return m_board[indexFromPosition(index.row(), index.column())];
}

void ScoreboardModel::display(QString newText, int startRow, int startCol)
{
    auto offset = indexFromPosition(startRow, startCol);
    std::copy(newText.begin(), newText.end(), m_board.begin() + offset);
    emit dataChanged(boundTopLeft({startRow, startCol}), boundBottomRight(positionFromIndex(offset - 1 + newText.size())));
}

void ScoreboardModel::display(QString newText)
{
    qDebug() << "Displaying " << newText << Qt::endl;
    display(newText, 0, 0);
}

void ScoreboardModel::fill(QChar ch)
{
    for (auto& c : m_board) {
        c = ch;
    }
    emit dataChanged(index(0, 0), index(m_rows - 1, m_columns - 1));
}

void ScoreboardModel::clear()
{
    fill(' ');
}

