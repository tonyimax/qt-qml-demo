#include "DataVM.h"
#include <QDir>
#include <QThread>
#include <QDateTime>
#include <QCryptographicHash>
#include "FileCopyer.h"
//单例指针
DataVM* DataVM::m_instance = nullptr;
//构造
DataVM::DataVM(QObject *parent /*= nullptr*/) : QObject(parent)
{
}
//拆构
DataVM::~DataVM()
{
}
//获取单例
DataVM* DataVM::getInstance()
{
    if (m_instance == nullptr){
        m_instance = new DataVM();//创建单例
    }
    return m_instance;//返回单例
}
//构造单例
QObject* DataVM::instance(QQmlEngine* engine, QJSEngine* scriptEngine)
{
    Q_UNUSED(engine) //表示该参数不使用
    Q_UNUSED(scriptEngine)//表示该参数不使用
    return getInstance();
}
//文件复制
//filePaths:文件地址列表
void DataVM::copyFiles( QList<QUrl> filePaths)
{
    //源文件路径列表 与 目标文件路径列表
    QVector<QString> srcFilePaths, dstFilePaths;
    //遍历要复制的所有文件
    for(auto &path : filePaths)
    {
        //取文件真实路径
        auto realPath = path.toString().remove(0, 8);
        //保存源文件列表
        srcFilePaths.push_back(realPath);
        //取复制文件名
        QString fileName = QFileInfo(realPath).fileName();
        //构造目标复制路径
        auto newFilePath = "C:/copyfile/" + fileName;
        //保存目标复制路径列表
        dstFilePaths.push_back(newFilePath);
    }
    //创建新线程
    auto local = new QThread;
    //释放原指针指向的内存空间
    m_worker.reset(new FileCopyer(local));
    //信号连接
    QObject::connect(
                m_worker.get(), //取指针指向的对象
                &FileCopyer::finished,//文件复制完成信号
                //匿名函数，处理finished信号的槽函数
                [&](bool s) {
                    emit sigAllCopyFilesFinished();//发射所有文件复制完成信号
                }
    );
    //信号连接
    QObject::connect(
        m_worker.get(),//取指针指向的对象
        &FileCopyer::oneBegin,//单个文件开始复制信号
        //匿名函数，处理单个文件开始复制信号
        //fileName 要复制的文件名
        [&](QString fileName) {
            emit sigOneCopyFileBegin(fileName);//发射单个文件开始复制信号
        }
    );
    //信号连接
    QObject::connect(
        m_worker.get(), //取指针指向的对象
        &FileCopyer::oneFinished, //单个文件复制完成信号
        //匿名函数，处理单个文件复制完成信号
        //dstPath 目标路径  result 复制结果
        [&](QString dstPath, bool result) {
            if(!result)
            {
                return;
            }
        }
    );
    //信号连接
    QObject::connect(
         m_worker.get(),//取指针指向的对象
         &FileCopyer::copyProgress,//单个文件复制进度信号
         //匿名函数，处理单个文件复制进度信号
         //copy 已复制大小  total 文件大小
         [&](qint64 copy, qint64 total) {
            emit sigCopyFileProgress(qreal(copy) / qreal(total) );//发射单个文件复制进度
         }
    );
    //设置源路径
    m_worker.get()->setSourcePaths(srcFilePaths);
    //设置目标路径
    m_worker.get()->setDestinationPaths(dstFilePaths);
    //启动复制线程
    local->start();
}
//中断文件复制
void DataVM::interruptCopyFile()
{
    m_worker->interrupt();//终止复制线程
}
