#include <QObject>
class Log4Qml : public QObject
{
    Q_OBJECT

public:
    //构造函数
    Log4Qml();
    //注册QML前端写日志方法
    Q_INVOKABLE void qDebug_Info(int type, QString strInfo);
};
