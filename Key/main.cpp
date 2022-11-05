#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include "Key.h"

int main(int argc, char *argv[])
{
    //QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    Key qmlKey;
    QQmlApplicationEngine engine;
    //注册C++键盘事件类
    engine.rootContext()->setContextProperty("qmlKey", &qmlKey);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    QObject *root = engine.rootObjects()[0];
    //安装事件过滤器
    root->installEventFilter(&qmlKey);
    //链接信号与槽函数
    QObject::connect(&qmlKey, SIGNAL(sigKeyAPress()), root, SLOT(onSigKeyAPress()));
    QObject::connect(&qmlKey, SIGNAL(sigKeyARelease()), root, SLOT(onSigKeyARelease()));
    return app.exec();
}
