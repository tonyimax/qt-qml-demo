#include "Log4Qml.h"
#include <QMutex>
#include <QFile>
#include <QDateTime>
#include <QTextStream>
//输出日志消息
//type : 消息类型
//context : 消息上下文
//msg : 消息内容
void outputMessage(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    static QMutex mutex;
    mutex.lock();//写消息时给outputMessage方法加上锁

    QString text;
    //消息类型判断
    switch(type)
    {
    case QtDebugMsg:
        text = QString("调试信息:");
        break;

    case QtWarningMsg:
        text = QString("警告信息:");
        break;

    case QtCriticalMsg:
        text = QString("临界信息:");
        break;

    case QtFatalMsg:
        text = QString("致命性信息:");
    }
    //消息内容格式化
    QString message = "";
    if (context.file != nullptr)
    {
        //内容信息
        QString context_info = QString("日志文件:(%1) 所在行:(%2)").arg(QString(context.file)).arg(context.line);
        //当前日期
        QString current_date_time = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss ddd");
        QString current_date = QString("(%1)").arg(current_date_time);
        //输出格式: 消息类型 + 内容信息 + 消息 + 当前日期
        message = QString("%1 %2 %3 %4").arg(text).arg(context_info).arg(msg).arg(current_date);
    }
    else
    {
        message = msg;
    }

    //操作日志文件写入日志
    QFile file("log.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Append);
    QTextStream text_stream(&file);
    text_stream << message << "\r\n";
    file.flush();//刷新写入内容
    file.close();//关闭文件流
    //写完消息后给outputMessage方法加解锁
    mutex.unlock();
}
//构造函数
Log4Qml::Log4Qml()
{
    qInstallMessageHandler(outputMessage);//安装日志消息处理函数
}
//实现注册给QML使用的日志输出函数
//type : 日志类型
//strInfo : 日志内容
void Log4Qml::qDebug_Info(int type, QString strInfo)
{
    QMessageLogContext context;//消息日志上下文
    context.file = "";//null 不会输出格式化消息
    outputMessage((QtMsgType)type, context, strInfo);//输出日志
}
