#pragma once
#include <QQuickImageProvider>
#include <QDebug>
#include <QCoreApplication>
// 继承QQuickImageProvider类自定义图像提供者
class ImageProviderPixmap : public QQuickImageProvider
{
public:
    //构造
    ImageProviderPixmap(ImageType type, Flags flags = Flags()) : QQuickImageProvider(type, flags)
    {
    }
    //析构
    ~ImageProviderPixmap(){}
    //重写基类requestPixmap函数请求图像
    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
    {
        //直接读取应用所有目录下图像
        QString strFileName = QCoreApplication::applicationDirPath() + "/" + id;
        //输出图像路径
        qDebug() << strFileName;
        //根据图像名构造pixmap对象
        QPixmap pixmap(strFileName);
        //返回pixmap对象
        return pixmap;
    }
};
