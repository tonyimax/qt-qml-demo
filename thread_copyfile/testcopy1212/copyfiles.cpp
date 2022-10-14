#include "copyfiles.h"

CopyFiles::CopyFiles(QString Sourecfilepath,QString  TargetPath,QObject *parent) : QObject(parent)
{
    qDebug() << QThread::currentThreadId() << Sourecfilepath <<  TargetPath;
}
bool CopyFiles::copyFileFunction( QString fromFIleName,  QString toFileName)
{
    qDebug() <<  "复制文件子线程id:" <<QThread::currentThreadId();
    char* byteTemp = new char[8192];//字节数组
    qint64 fileSize = 0;
    qint64 totalCopySize = 0;
    QFile tofile;
    tofile.setFileName(toFileName);
    if(!tofile.open(QIODevice::WriteOnly))
    {
        qDebug() <<  "无法打开目录" << toFileName;
        return false;
    }
    QDataStream out(&tofile);
    out.setVersion(QDataStream::Qt_4_0);

    QFile fromfile;
    fromfile.setFileName(fromFIleName);
    if(!fromfile.open(QIODevice::ReadOnly)){
        return false;
    }
    fileSize = fromfile.size();
    QDataStream in(&fromfile);
    in.setVersion(QDataStream::Qt_4_0);
    qDebug()<<"文件总大小 : "<<QString::number(fileSize);
    while(!in.atEnd())
    {
        qint64 readSize = 0;
        //读入字节数组,返回读取的字节数量，如果小于8192，则到了文件尾
        readSize = in.readRawData(byteTemp, 8192);
        out.writeRawData(byteTemp, readSize);
        totalCopySize += readSize;
        int tmpVal = totalCopySize / (double)fileSize * 100;
        emit copy_process(QString::number(tmpVal));
    }
    //复制完成
    if(totalCopySize == fileSize){
        tofile.setPermissions(QFile::ExeUser);
        tofile.close();
        fromfile.close();
        qDebug() << "复制完成";
        return true;
    }
    else
        return false;
}
