#include <QApplication>
#include <QtQml>
#include <QQmlApplicationEngine>
#include  "copyhelper.h"
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("copyhelper", new CopyHelper);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));



    return app.exec();
}
