#include <QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQml>
#include "imageProcessor.h"
#include <QQuickItem>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<ImageProcessor>("an.qt.ImageProcessor", 1, 0,"ImageProcessor");
    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setTitle("Qt基于Qml图像处理演示");
    viewer.setSource(QUrl("qrc:///main.qml"));
    viewer.show();
    return app.exec();
}
