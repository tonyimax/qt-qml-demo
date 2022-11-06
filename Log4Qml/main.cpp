#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Log4Qml.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    Log4Qml log4Qml;//日志操作类对象
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("log4Qml", &log4Qml);//注册日志操作类到QML引擎
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    return app.exec();
}
