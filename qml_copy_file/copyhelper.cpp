#include "copyhelper.h"
#include <QDebug>
#include <QFile>
#include <QDataStream>
#include <QThread>
#include <QFileInfo>
#include "copyfiles.h"
//构造
CopyHelper::CopyHelper(QObject *parent) : QObject(parent)
{
  qDebug() << "文件复制助手线程ID:" <<QThread::currentThreadId();
}
//复制文件到目录
QString CopyHelper::copyFileToDir(QString _filePath)
{
   QString absolutePath = _filePath.remove(0,8);//文件绝对路径
   qDebug()<< "文件绝对路径:" << absolutePath;
   QFileInfo fininfo(absolutePath);//文件信息
   QString dstPath = "c:/copyfile/"+fininfo.fileName();
   CopyFiles * m_pCopyFile = new CopyFiles(_filePath,dstPath);//构造复制文件类
   QThread *   m_pCopyFilethread =  new QThread();//复制文件子线程
   m_pCopyFile->moveToThread(m_pCopyFilethread); //子线程中执行文件复制
   //连接文件复制信号
   connect(m_pCopyFile,SIGNAL(starCopy(QString,QString)),m_pCopyFile,SLOT(copyFileFunc(QString,QString)));
   connect(m_pCopyFile,SIGNAL(copyProcess(QString,quint32,quint32)),this,SLOT(reciveCopyProgress(QString,quint32,quint32)));
   //链接线程完成信号
   connect(m_pCopyFilethread, SIGNAL(finished()), m_pCopyFilethread, SLOT(deleteLater()));
   connect(m_pCopyFilethread, &QThread::finished, m_pCopyFilethread, &QObject::deleteLater);
   //启动复制线程
   m_pCopyFilethread->start();
   //发射文件复制开始信号
   emit m_pCopyFile->starCopy(absolutePath,dstPath);
   return "复制成功";
}
//测试读取文件
void CopyHelper::testReadFile()
{
    QString strFileName ="c:/test.rar";//测试复制文件
    if (!QFile::exists(strFileName)){return;} //文件不存在
    QFile file(strFileName);
    if (!file.open(QFile::ReadOnly)){return;}//文件无法打开
    QDataStream in(&file);//数据流
    int nFileSize = file.size();//文件大小
    int p = 0;//当前复制位置
    while (!in.atEnd()) {
         char  buffer [8192];
         int readsize = 0;
         readsize = in.readRawData(buffer,8192);
         p = file.pos();
         qDebug() <<"文件总大小:"<<nFileSize<<"读取大小"<<readsize<<" 当前复制进度"<<QString::number(p);
   }
}
//接收文件进度
void CopyHelper::reciveCopyProgress(QString value,quint32 nCopyUnit,quint32 nNeedCopyTime)
{
    emit qmlCopyProgress(value,nCopyUnit,nNeedCopyTime);//发射接收文件进度
}
