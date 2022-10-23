#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "QmlPluginTest.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QmlPluginTest qmlPluginTest;
    engine.rootContext()->setContextProperty("qmlPluginTest", &qmlPluginTest);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
