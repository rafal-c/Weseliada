#ifndef ANSWERLISTMODEL_H
#define ANSWERLISTMODEL_H

#include <QAbstractListModel>

struct Answer {
    int points;
    QString text;

    friend bool operator==(const Answer& a1, const Answer& a2) {
        return a1.points == a2.points && a1.text == a2.text;
    }

    friend bool operator!=(const Answer& a1, const Answer& a2) {
        return !(a1 == a2);
    }

    friend bool operator>(const Answer& a1, const Answer& a2) {
        if (a1.points > a2.points) {
            return true;
        }
        if (a1.points < a2.points) {
            return false;
        }
        if (a1.text > a2.text) {
            return true;
        }
        return false;
    }

    friend bool operator>=(const Answer& a1, const Answer& a2) {
        return a1 == a2 || a1 > a2;
    }

    friend bool operator<(const Answer& a1, const Answer& a2) {
        return !(a1 >= a2);
    }

    friend bool operator<=(const Answer& a1, const Answer& a2) {
        return a1 == a2 || a1 < a2;
    }
};

class AnswerListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        TextRole = Qt::UserRole + 1,
        PointsRole
    };
    Q_ENUM(Roles)

    QHash<int, QByteArray> roleNames() const override {
        return {
            { TextRole, "text" },
            { PointsRole, "points" }
        };
    }
    explicit AnswerListModel(QObject *parent = nullptr);

    AnswerListModel(std::vector<Answer> initialAnswers, QObject *parent = nullptr) : answers {std::move(initialAnswers)} {
        std::sort(std::begin(answers), std::end(answers));
    }

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void addAnswer(Answer a) {
        answers.push_back(std::move(a));
    }

private:
    std::vector<Answer> answers;
};

#endif // ANSWERLISTMODEL_H
