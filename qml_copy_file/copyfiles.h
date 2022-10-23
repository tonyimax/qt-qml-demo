#ifndef COPYFILES_H
#define COPYFILES_H
//头文件包含
#include <QObject>
#include <QDebug>
#include <QFile> //文件操作
#include <QDataStream> //数据流
#include <QThread> //线程
#include <QTime>
//继承QObject供QML使用
/**
 * @brief 文件复制类
 */
class CopyFiles : public QObject
{
    Q_OBJECT
public:
    //只能显式构造
    /**
     *  QString _srcFilePath ：源文件路径
     *  QString _dstPath : 目标路径
     *  QObject *parent = 0 ：父对象指针，默认为空
    */
    explicit CopyFiles(QString _srcFilePath,QString _dstPath,QObject *parent = 0);
signals:
   void starCopy(QString,QString);//复制文件信号
   void copyProcess(QString,quint32,quint32); //复制文件进度信号

public slots:
     /**
       * @brief copyFileFunction : 复制文件信号处理槽
       * @param _from : 源文件名
       * @param _to : 目标文件名
       * @return bool : 返回类型 成功返回true 失败返回false
       */
      bool copyFileFunc( QString _from,  QString _to);//槽
};
#endif // COPYFILES_H
