#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Language.h"

int main(int argc, char *argv[])
{
    //QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    Language Language(app, engine);//语言国际化对象
    engine.rootContext()->setContextProperty("Language", &Language);//注册QML对象
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    return app.exec();
}
