#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "QmlTableView.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    //C++原生对象
    QmlTableViewModel model;
    //调用对象方法
    model.Add(QStringLiteral("初始化"), QStringLiteral("123"), QStringLiteral("456"));
    ////添加原生对象实例到根上下文,供QML调用
    engine.rootContext()->setContextProperty("CppDefindModelObject", &model);

    //加载主QML
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
