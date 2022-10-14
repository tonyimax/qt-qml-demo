#ifndef COPYHELPER_H
#define COPYHELPER_H

#include <QObject>

class CopyHelper : public QObject
{
    Q_OBJECT
public:
    explicit CopyHelper(QObject *parent = 0);
  public:
      Q_INVOKABLE QString copyfiletoDir(QString);
signals:
    void  qml_copy_pro(QString provalu);
public slots:

private :
    void testredfile();

private slots:

     void reciveCopyPro(QString);
};

#endif // COPYHELPER_H
