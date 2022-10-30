#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include "ImageProviderPixmap.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    //添加图像提供者到QML引擎
    engine.addImageProvider(QLatin1String("imageProviderPixmap"), new ImageProviderPixmap(QQmlImageProviderBase::Pixmap));
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    return app.exec();
}
