#include "QmlTableView.h"
#include <QDebug>

//构造并初始化基类QAbstractTableModel
QmlTableViewModel::QmlTableViewModel() : QAbstractTableModel(0)
{
}

//实现重写函数rowCount
int QmlTableViewModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_aryData.size();
}

//实现重写函数columnCount
int QmlTableViewModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 3;
}

//实现重写函数data
QVariant QmlTableViewModel::data(const QModelIndex &index, int role) const
{
    return m_aryData[index.row()][role];
}

//显示名
QHash<int, QByteArray> QmlTableViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Role1] = "DisplayRole1";
    roles[Role2] = "DisplayRole2";
    roles[Role3] = "DisplayRole3";
    return roles;
}

//自定义函数实现Add
void QmlTableViewModel::Add(QString one, QString two, QString three)
{
    beginInsertRows(QModelIndex(), m_aryData.size(), m_aryData.size());
    QVector<QString> list;
    list.push_back(one);
    list.push_back(two);
    list.push_back(three);
    m_aryData.push_back(list);
    endInsertRows();
}

//自定义函数实现Set
void QmlTableViewModel::Set(int row, int column, QString text)
{
    if (row == -1){return;}
    if (column == -1){return;}
    beginResetModel();
    m_aryData[row][column] = text;
    endResetModel();
}

//自定义函数实现Del
void QmlTableViewModel::Del()
{
    if (m_aryData.size() <= 0) return;
    beginRemoveRows(QModelIndex(), m_aryData.size() - 1, m_aryData.size() - 1);
    m_aryData.removeLast();
    endRemoveRows();
}

//自定义函数实现Refresh
void QmlTableViewModel::Refresh()
{
    beginResetModel();
    endResetModel();
}
