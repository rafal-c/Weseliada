#include "answerlistmodel.h"

AnswerListModel::AnswerListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int AnswerListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return answers.size();
}

QVariant AnswerListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    auto& a = answers.at(index.row());
    if (role == TextRole) {
        return a.text;
    }
    if (role == PointsRole) {
        return a.points;
    }
    if (role == EnabledRole) {
        return activeQ();
    }
    return {};
}


bool AnswerListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid() || role != GuessedRole)
        return false;
    auto& a = answers.at(index.row());
    a.guessed = value.toBool();
    emit dataChanged(index, index, {role});
    return true;
}
