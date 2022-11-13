#pragma once
#include <QtCore/qstring.h>
#include <QtCore/qobject.h>
#include <QtCore/qfile.h>
#include <QtCore/qfileinfo.h>
#include <QtCore/qvector.h>
#include <QtCore/qthread.h>
class FileCopyer : public QObject {
    Q_OBJECT
        //可读可写属性
        //chunksize复制大小
        Q_PROPERTY(qint64 chunksize READ chunkSize WRITE setChunkSize)
        //sourcePaths 源路径
        Q_PROPERTY(QVector<QString> sourcePaths READ sourcePaths WRITE setSourcePaths)
        //destinationPaths 目标路径
        Q_PROPERTY(QVector<QString> destinationPaths READ destinationPaths WRITE setDestinationPaths)
public:
    //默认复制大小1M
    static const int DEFAULT_CHUNK_SIZE = 1024 * 1024 * 1;
    //构造并传入线程指针
    FileCopyer(QThread*);
    //拆构
    ~FileCopyer();
    //取文件大小
    qint64 chunkSize() const {
        return _chunk;
    }
    //设置复制文件大小
    void setChunkSize(qint64 ch) {
        _chunk = ch;
    }
    //源路径
    QVector<QString> sourcePaths() const {
        return src;
    }
    //设置源路径
    void setSourcePaths(const QVector<QString>& _src) {
        src = _src;
    }
    //目标路径
    QVector<QString> destinationPaths() const {
        return dst;
    }
    //设置目标路径
    void setDestinationPaths(const QVector<QString>& _dst) {
        dst = _dst;
    }
    //中断
    void interrupt()
    {
        _interrupt = true;
    }
    protected slots:
    //复制槽
    void copy();
private:
    //单个源路径与单个目标路径
    QVector<QString> src, dst;
    //文件大小
    qint64 _chunk;
    //是否已中断
    bool _interrupt;
//信号
signals:
    //复制文件信号bytesCopied：已复制大小  bytesTotal ：文件总大小
    void copyProgress(qint64 bytesCopied, qint64 bytesTotal);
    //是否已复制完成
    void finished(bool success);
    //开始复制单个文件 srcFileName ：源文件名
    void oneBegin(QString srcFileName);
    //单个文件复制完成 dstPath ： 目标路径， result ：复制结果
    void oneFinished(QString dstPath, bool result);
};
