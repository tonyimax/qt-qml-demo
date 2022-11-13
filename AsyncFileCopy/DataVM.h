#pragma once
#include <QObject>
#include <QQmlEngine>
#include <QJSEngine>
#include <QString>
#include <QDebug>
#include <QQuickWindow>
#include <QFileInfoList>
#include "FileCopyer.h"
//数据虚拟机
class DataVM : public QObject
{
	Q_OBJECT
public:
    //获取单例
    static DataVM*   getInstance();
    //实例化单例
    static QObject*  instance(QQmlEngine* engine, QJSEngine* scriptEngine);
    //注册文件复制方法供qml用
    Q_INVOKABLE void copyFiles(QList<QUrl> filePaths);
    //注册中断文件复制方法供qml用
    Q_INVOKABLE void interruptCopyFile();
signals:
    //复制文件进度信号
    void sigCopyFileProgress(float progress);
    //开始复制单个文件信号
    void sigOneCopyFileBegin(QString fileName);
    //所有文件复制完成信号
    void sigAllCopyFilesFinished();
private:
    //构造
    DataVM(QObject* parent = nullptr);
    //拆构
    ~DataVM();
    //静态单例指针
    static DataVM* m_instance;
    //智能指针unique_ptr不能指向一个对象，不能进行复制操作,只能进行移动操作。
    std::unique_ptr<FileCopyer>   m_worker;
};
