#include <QApplication>
#include <QtQml>
#include <QQmlApplicationEngine>
#include  "copyhelper.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("copyhelper", new CopyHelper);//注册复制文件类
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
