#ifndef COPYHELPER_H
#define COPYHELPER_H
//头文件包含
#include <QObject>
//继承QObject供QML使用
/**
 * @brief 文件复制助手类
 */
class CopyHelper : public QObject
{
    Q_OBJECT
public:
    //只能显式构造
    /**
     * @brief CopyHelper ：构造函数
     * @param parent
     */
    explicit CopyHelper(QObject *parent = 0);
  public:
    /**
       * @brief copyFileToDir 复制文件到目录
       * @return QString 返回字符串
       */
      Q_INVOKABLE QString copyFileToDir(QString);
signals:
    /**
     * @brief qmlCopyProgress 供qml使用的复制文件进度信号
     * @param value
     */
    void  qmlCopyProgress(QString value,quint32 nCopyUnit,quint32 nNeedCopyTime);

public slots:

private :
    /**
     * @brief testReadFile 测试读取文件
     */
    void testReadFile();

private slots:
    /**
      * @brief reciveCopyProgress 接收文件进度槽
      */
     void reciveCopyProgress(QString,quint32,quint32);
};
#endif // COPYHELPER_H
