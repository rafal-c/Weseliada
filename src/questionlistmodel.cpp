#include "questionlistmodel.h"

#include <QDebug>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>

QuestionListModel::QuestionListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

QVariant QuestionListModel::headerData(int, Qt::Orientation, int) const
{
    return "";
}

int QuestionListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_questions.size();
}

QVariant QuestionListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    auto& q = m_questions.at(index.row());
    if (role == QuestionRole) {
        return q.text;
    }
    if (role == AnswersRole) {
        return QVariant::fromValue(q.answersList.get());
    }
    return {};
}

void QuestionListModel::readQuestionsFromFile(QString filePath)
{
    emit layoutAboutToBeChanged();
    QFile file {filePath};
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "Could not open config file " << filePath;
        return;
    }

    QString jsonString =  QTextStream {&file}.readAll();
    file.close();

    QJsonParseError error {};
    auto jsonDoc = QJsonDocument::fromJson(jsonString.toUtf8(), &error);
    if(jsonDoc.isNull()) {
        qDebug() << "Could not parse the JSON document: " << error.errorString();
        return;
    }
    QJsonValue questionsObj = jsonDoc["questions"];
    if(questionsObj.isUndefined()) {
        qDebug() << "JSON document is ill-formed";
        return;
    }
    const auto questionsList = questionsObj.toArray();
    for(auto q : questionsList) {
        const auto answers = q["answers"].toArray();
        auto ansModel = std::make_unique<AnswerListModel>();
        for(auto a : answers) {
            Answer ans {.points = a["points"].toInt(), .text = a["text"].toString()};
            ansModel->addAnswer(std::move(ans));
        }
        m_questions.emplace_back(q["text"].toString(), std::move(ansModel));
    }
    emit layoutChanged();
}
