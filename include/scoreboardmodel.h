#ifndef SCOREBOARDMODEL_H
#define SCOREBOARDMODEL_H

#include <QAbstractTableModel>
#include <QtQml/qqml.h>
#include <QVector>

class ScoreboardModel : public QAbstractTableModel
{
    Q_OBJECT
    Q_PROPERTY(int tileSpacing READ tileSpacing WRITE setTileSpacing NOTIFY tileSpacingChanged)

public:
    enum Roles {
        TextRole
    };
    Q_ENUM(Roles)

    QHash<int, QByteArray> roleNames() const override {
        return {
            { TextRole, "text" }
        };
    }
    explicit ScoreboardModel(int rows = 1, int columns = 1, QObject *parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void display(QString newText, int startRow, int startCol);

    Q_INVOKABLE void display(QString newText);

    Q_INVOKABLE void fill(QChar ch);

    Q_INVOKABLE virtual void clear();

    int tileSpacing() const {
        return m_tileSpacing;
    }

    void setTileSpacing(int tileSp) {
        m_tileSpacing = tileSp;
    }

signals:
    void tileSpacingChanged(int);

private:
    struct Position {
        int row;
        int column;
    };

    inline int indexFromPosition(int row, int col) const noexcept {
        return row * m_columns + col;
    }

    inline Position positionFromIndex(int pos) const noexcept {
        return {pos / m_columns, pos % m_columns};
    }

    QModelIndex modelIndexFromIndex(int pos) const {
        auto position = positionFromIndex(pos);
        return index(position.row, position.column);
    }

    inline QModelIndex boundTopLeft(const Position &start) const {
        return index(start.row, 0);
    }

    inline QModelIndex boundBottomRight(const Position &end) const {
        return index(end.row, m_columns - 1);
    }

    int m_tileSpacing = 10;
    int m_rows;
    int m_columns;
    QVector<QChar> m_board;

};

#endif // SCOREBOARDMODEL_H
