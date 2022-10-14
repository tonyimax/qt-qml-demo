#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QJSEngine>
#include <QString>
#include <QDebug>
#include <QQuickWindow>
#include <QFileInfoList>

#include "FileCopyer.h"

class DataVM : public QObject
{
	Q_OBJECT

public:
    static DataVM*                  getInstance();
    static QObject*                 instance(QQmlEngine* engine, QJSEngine* scriptEngine);

    Q_INVOKABLE void copyFiles(QList<QUrl> filePaths);
    Q_INVOKABLE void interruptCopyFile();
signals:
    void sigCopyFileProgress(float progress);
    void sigOneCopyFileBegin(QString fileName);
    void sigAllCopyFilesFinished();
private:
    DataVM(QObject* parent = nullptr);
    ~DataVM();
    static DataVM* m_instance;
    std::unique_ptr<FileCopyer>   m_worker;
};
