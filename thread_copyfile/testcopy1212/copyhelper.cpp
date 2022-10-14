#include "copyhelper.h"
#include <QDebug>
#include <QFile>
#include <QDataStream>
#include <QThread>
#include <QFileInfo>
#include "copyfiles.h"
CopyHelper::CopyHelper(QObject *parent) : QObject(parent)
{

  qDebug() <<QThread::currentThreadId();

}
QString CopyHelper::copyfiletoDir(QString filepath)
{
   QString absoluteFilePath = filepath.remove(0,8);
   qDebug()<< "文件绝对路径:" << absoluteFilePath;
   QFileInfo fininfo(absoluteFilePath);
   QString target_path = "C:/copyfile/"+fininfo.fileName();
    CopyFiles * DoCopy_File = new CopyFiles(filepath,target_path);
   QThread *   childthread =  new QThread();
   DoCopy_File->moveToThread(childthread); //放到子线程中传输
   connect(DoCopy_File,SIGNAL(starcopy(QString,QString)),DoCopy_File,SLOT(copyFileFunction(QString,QString)));
   connect(DoCopy_File,SIGNAL(copy_process(QString)),this,SLOT(reciveCopyPro(QString)));
   connect(childthread, SIGNAL(finished()), childthread, SLOT(deleteLater()));
   connect(childthread, &QThread::finished, childthread, &QObject::deleteLater);
   childthread->start();
   emit DoCopy_File->starcopy(absoluteFilePath,target_path);
   return "ok";
}
void CopyHelper::testredfile()
{

    QString _filename ="C:/Users/devel/Desktop/Base_P.zip";
    if (!QFile::exists(_filename))
      return;
    QFile file(_filename);
      if (!file.open(QFile::ReadOnly))
    return;
    QDataStream in(&file);
    int tsize = file.size();
    qDebug() <<tsize;
    int p = 0;
    while (!in.atEnd()) {
         char  buffer [2048];
         int readsize = 0;
         readsize = in.readRawData(buffer,2048);
         p = file.pos();
         qDebug() <<readsize;
         qDebug() <<"pross...."<<QString::number(p);

        }

}

void CopyHelper::reciveCopyPro(QString Pro_valu)
{
    emit qml_copy_pro(Pro_valu);
}
