#include "ImageViewProvider.h"
//初始化
ImageViewProvider::ImageViewProvider() : QQuickImageProvider(QQuickImageProvider::Image)
{
}
//根据索引更新图像
void ImageViewProvider::updateImageView(int index, const QImage &objImage)
{
    m_ImageViews[index] = objImage;
}
//请求图像对象
QImage ImageViewProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    //取图像索引
    int imageIndex = id.left(id.indexOf("###")).toInt();
    //根据索引取图像
    QImage objImage = m_ImageViews[imageIndex];
    //如果图像有效
    if (!objImage.isNull()) {
        objImage.scaled(requestedSize);
        if (size) *size = requestedSize;//图像大小
    }
    //返回图像对象
    return objImage;
}
