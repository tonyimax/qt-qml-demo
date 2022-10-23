#include "copyfiles.h"

CopyFiles::CopyFiles(QString Sourecfilepath,QString  TargetPath,QObject *parent) : QObject(parent)
{
    qDebug() << QThread::currentThreadId() << Sourecfilepath <<  TargetPath;
}
//复制文件时间计算公式：
//每秒已复制大小 === 速率
//文件总大小 / 速率 = 复制时间
//(文件总大小-已复制大小) / 速率 = 剩余复制时间
bool CopyFiles::copyFileFunc( QString _from,  QString _to)
{
    qDebug() <<  "子线程ID:" <<QThread::currentThreadId();
    QTime mTime;
    mTime.start();
    char* byteTemp = new char[8192];//每次复制8k
    qint64 fileSize = 0;
    qint64 totalCopySize = 0;
    //文件对象
    QFile tofile;
    tofile.setFileName(_to);
    QFile fromfile;
    fromfile.setFileName(_from);
    //文件读取判断
    if(!tofile.open(QIODevice::WriteOnly))
    {
        qDebug() << "无法打开目标文件";
        return false;
    }
    if(!fromfile.open(QIODevice::ReadOnly)){
        qDebug() << "无法打开目标文件";
        return false;
    }
    //文件大小
    QDataStream out(&tofile);//文件流
    out.setVersion(QDataStream::Qt_4_0);
    fileSize = fromfile.size();
    QDataStream in(&fromfile);
    in.setVersion(QDataStream::Qt_4_0);
    qDebug()<<"文件总大小:"<<QString::number(fileSize);
    //循环复制文件
    while(!in.atEnd())
    {
        qint64 readSize = 0;
        //每次读取8k
        readSize = in.readRawData(byteTemp, 8192);//读取复制文件到缓存并返回读取的实际大小
        out.writeRawData(byteTemp, readSize);//写到输出流
        totalCopySize += readSize;//累计已复制大小
        int tmpVal = totalCopySize / (double)fileSize * 100;//复制进度计算
        if(mTime.elapsed()<1000){
            emit copyProcess(QString::number(tmpVal),0,0);//发射当前复制进度
        }
        if((mTime.elapsed()%1000)==0){
            quint32 m = mTime.elapsed()/1000.000;
            qDebug()<< "每秒复制大小:" <<totalCopySize/m/1024<<"kb" <<
                       " 剩余复制时间:" <<(fileSize - totalCopySize)/(totalCopySize/m/1024)/1000;
            quint32 nCopyUnit = totalCopySize/m/1024;
            quint32 nNeedCopyTime = (fileSize - totalCopySize)/(totalCopySize/m/1024)/1000;
            emit copyProcess(QString::number(tmpVal),nCopyUnit,nNeedCopyTime);//发射当前复制进度
        }
        if(totalCopySize == fileSize){
            emit copyProcess(QString::number(tmpVal),0,0);
        }
    }
    //复制完成
    if(totalCopySize == fileSize){
        qDebug() << "复制文件所需时间" << mTime.elapsed() / 1000.00;
        tofile.setPermissions(QFile::ExeUser);//设置文件权限
        tofile.close();//关闭文件流
        fromfile.close();//关闭文件流
        return true;//返回复制结果-成功
    }
    else
        return false;//返回复制结果-失败
}
