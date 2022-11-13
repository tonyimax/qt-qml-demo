#include <QtCore/qdebug.h>
#include "FileCopyer.h"
//构造，初始化_interrupt
FileCopyer::FileCopyer(QThread* _thread) :QObject(nullptr),_interrupt(false)
{
    moveToThread(_thread);//与线程关联
    setChunkSize(DEFAULT_CHUNK_SIZE);//初始化复制大小缓存
    //信号连接
    QObject::connect(
                _thread, //线程对象
                &QThread::started,//线程启动信号
                this, //文件复制类对象
                &FileCopyer::copy);//处理线程started信号，调用copy复制文件
    //信号连接
    QObject::connect(
                _thread, //线程对象
                &QThread::finished, //线程发出的完成信号
                _thread, //线程对象
                &QThread::deleteLater);//延迟释放QObject对象 ，先线程使用资源，然后再调用quit退出线程
    //信号连接
    QObject::connect(
                this, //文件复制类对象
                &FileCopyer::finished, //复制完成信号
                _thread, //线程对象
                &QThread::quit);//处理复制完成信号，退出线程
}
//拆构
FileCopyer::~FileCopyer() {
}
//文件复制
void FileCopyer::copy() {
    //空路径判断
    if (src.isEmpty() || dst.isEmpty()) {
        qWarning() << QString(u8"源路径或者目标路径为空!");
        emit finished(false);//发射信号
        return;
    }
    //源路径与目标路径数量判断
    if (src.count() != dst.count()) {
        qWarning() << QString(u8"源路径与目标路径不匹配!");
        emit finished(false);//发射信号
        return;
    }
    //初始化文件大小
    qint64 total = 0, written = 0;
    //遍历要复制的文件列表，统计总复制文件大小
    for (const auto& f : src){
        total += QFileInfo(f).size();
    }
    qInfo() << QString(u8"需要复制的文件总大小%1 bytes").arg(total);
    int index = 0;
    qInfo() << QString(u8"每次复制文件大小%1 byte").arg(chunkSize());
    //遍历所有要复制的文件
    while (index < src.count()) {
        const auto dstPath = dst.at(index);
        //源文件
        QFile srcFile(src.at(index));
        //目标文件
        QFile dstFile(dstPath);
        //文件存在判断
        if (QFile::exists(dstPath)) {
            qInfo() << QString(u8"文件%1已存在, 正在覆盖...").arg(dstPath);
            QFile::remove(dstPath);
        }
        //文件可读判断
        if (!srcFile.open(QFileDevice::ReadOnly)) {
            qWarning() << QString(u8"打开文件%1失败(错误:%2)").arg(srcFile.fileName()).arg(srcFile.errorString());
            index++;
            continue;//跳过无法读取文件
        }
        //文件可写判断
        if (!dstFile.open(QFileDevice::WriteOnly)) {
            qWarning() << QString(u8"写入文件%1失败(错误:%2)").arg(dstFile.fileName()).arg(dstFile.errorString());
            index++;
            continue;//跳过无法写入文件
        }
        //发射单个文件开始复制信号，并传入文件名为参数
        emit oneBegin(QFileInfo(srcFile).fileName());
        //取复制文件大小
        qint64 fSize = srcFile.size();
        //循环复制文件
        while (fSize) {
            //如果单个文件复制完成
            if(_interrupt)
            {
                emit finished(true);//发射单个文件复制完成信号
                return;
            }
            //读取文件到缓存 1M大小
            const auto data = srcFile.read(chunkSize());
            //写入文件并返回写入的大小
            const auto _written = dstFile.write(data);
            //校验文件大小
            if (data.size() == _written) {
                written += _written;//累计已写入大小
                fSize -= data.size();//剩余未写入大小
                emit copyProgress(written, total);//发射复制进度
            } else {
                emit oneFinished(dstPath, false);//发射复制文件失败信号
                qWarning() << QStringLiteral("复制文件%1失败(错误:%2)").arg(dstFile.fileName()).arg(dstFile.errorString());
                fSize = 0;//重置文件大小
                break;//跳出当前复制操作，复制下一个文件
            }
        }
        srcFile.close();//释放文件实例
        dstFile.close();//释放文件实例
        emit oneFinished(dstPath, true);//发射单个文件复制完成信号
        index++;
        qDebug() << QThread::currentThreadId();
    }
    //所有文件已复制完成
    if (total == written) {
        qInfo() << QString(u8"文件复制完成 , %1 bytes of %2 成功写入").arg(written).arg(total);
        emit finished(true);//发射所有文件复制完成信号，通知线程停止
    } else {
        emit finished(false);//发射未完全复制完成信号
    }
}
