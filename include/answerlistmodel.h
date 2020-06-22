#ifndef ANSWERLISTMODEL_H
#define ANSWERLISTMODEL_H

#include <QAbstractListModel>

struct Answer {
    int points;
    QString text;
    bool guessed = false;

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
        PointsRole,
        EnabledRole,
        GuessedRole,
    };
    Q_ENUM(Roles)

    QHash<int, QByteArray> roleNames() const override {
        return {
            { TextRole, "text" },
            { PointsRole, "points" },
            { EnabledRole, "active" },
            { GuessedRole, "guessed" }
        };
    }
    explicit AnswerListModel(QObject *parent = nullptr);

    AnswerListModel(std::vector<Answer> initialAnswers, QObject *parent = nullptr) : answers {std::move(initialAnswers)} {
        std::sort(std::begin(answers), std::end(answers));
    }

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    void addAnswer(Answer a) {
        answers.push_back(std::move(a));
    }

    int activeQ() const {
        return m_activeQ;
    }

    void setActiveQ(bool active) {
        m_activeQ = active;
        emit dataChanged(index(0), index(answers.size() - 1), {EnabledRole});
    }

private:
    std::vector<Answer> answers;
    bool m_activeQ = false;

};

#endif // ANSWERLISTMODEL_H
