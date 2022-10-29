#include "imageView.h"
#include "ImageViewProvider.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QmlImageView *qmlImageView = new QmlImageView;

    QQmlApplicationEngine engine;

    //添加图像提供者与注册QML对象
    engine.addImageProvider(QLatin1String("ViewMulti"), qmlImageView->ImageViewMulti());//添加多画面图像提供者到QML引擎
    engine.addImageProvider(QLatin1String("ViewSourceMulti"), qmlImageView->ImageViewSourceMulti());////添加多图像源提供者到QML引擎
    engine.rootContext()->setContextProperty("QmlImageView", qmlImageView);//注册QML对象

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
