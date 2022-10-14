#ifndef COPYFILES_H
#define COPYFILES_H

#include <QObject>
#include <QDebug>
#include <QFile>
#include <QDataStream>
#include <QThread>
class CopyFiles : public QObject
{
    Q_OBJECT
public:
    explicit CopyFiles(QString Sourecfilepath,QString TargetPath,QObject *parent = 0);

signals:
   void starcopy(QString,QString);

   void copy_process(QString); //进度

public slots:
      bool copyFileFunction( QString fromFIleName,  QString toFileName);
};

#endif // COPYFILES_H
