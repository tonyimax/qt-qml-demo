#pragma once
#include <QAbstractTableModel> //QAbstractTableModel定义所在头文件
#include <QVector>
//枚举
enum Role {
    Role1,
    Role2,
    Role3
};

//继承QAbstractTableModel,而QAbstractTableModel继承于QAbstractItemModel
class QmlTableViewModel : public QAbstractTableModel
{
    Q_OBJECT //供QML访问的类 QObject类的子类必须包含这个宏 QT会调用moc元对象编译器来编译该类

public:
    explicit QmlTableViewModel(); //构造函数 只能显示转换,防止被隐藏转换

    //Q_DECL_OVERRIDE 相当于C++中的override  重写基类相关函数
    //类基于QAbstractItemModel声明的虚函数 rowCount columnCount data roleNames
    //行数
    int rowCount(const QModelIndex & parent = QModelIndex()) const Q_DECL_OVERRIDE; //重写基类函数
    //列数
    int columnCount(const QModelIndex &parent = QModelIndex()) const Q_DECL_OVERRIDE;//重写基类函数
    //数据 DisplayRole为单元格显示状态
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const Q_DECL_OVERRIDE;//重写基类函数
    //角色类
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE; //重写基类函数

    //自定义函数 Q_INVOKABLE 定义的函数QML可调用
    //增加
    Q_INVOKABLE void Add(QString one, QString two, QString three);
    //修改
    Q_INVOKABLE void Set(int row, int column, QString text);
    //删除
    Q_INVOKABLE void Del();
    //刷新
    Q_INVOKABLE void Refresh();

private:
    //用保存数据的私有变量
   QVector<QVector<QString>> m_aryData;
};
