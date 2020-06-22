#ifndef QUESTIONLISTMODEL_H
#define QUESTIONLISTMODEL_H

#include <memory>

#include <QAbstractListModel>
#include "answerlistmodel.h"

struct Question {
    QString text;
    std::unique_ptr<AnswerListModel> answersList;
};

class QuestionListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int activeQuestion READ activeQuestion WRITE setActiveQuestion NOTIFY activeQuestionChanged)

public:
    enum Roles {
        QuestionRole = Qt::UserRole + 1,
        AnswersRole
    };
    Q_ENUM(Roles)

    QHash<int, QByteArray> roleNames() const override {
        return {
            { QuestionRole, "question" },
            { AnswersRole, "answers" }
        };
    }

    explicit QuestionListModel(QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void readQuestionsFromFile(QString filePath);

    int activeQuestion() const {
        return m_activeQuestion;
    }

    void setActiveQuestion(int newActive) {
        if (!validQuestionIndex(newActive)) {
            return;
        }
        if (validQuestionIndex(m_activeQuestion)) {
            m_questions[m_activeQuestion].answersList->setActiveQ(false);
        }
        m_activeQuestion = newActive;
        m_questions[newActive].answersList->setActiveQ(true);
    }

signals:
    void activeQuestionChanged(int);

private:
    bool validQuestionIndex(int i) const noexcept {
        return i >= 0 && i < m_questions.size();
    }

    std::vector<Question> m_questions;
    int m_activeQuestion = -1;
};

#endif // QUESTIONLISTMODEL_H
