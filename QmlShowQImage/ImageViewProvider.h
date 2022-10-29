#ifndef IMAGEVIEW_PROVIDER_HEAD
#define IMAGEVIEW_PROVIDER_HEAD
#include <QQuickImageProvider>
//构造自定义图像提供者
class ImageViewProvider : public QQuickImageProvider
{
public:
    //构造函数
    ImageViewProvider();
    //通过索引更新指定图像
    void updateImageView(int index, const QImage &objImage);
    //重写基类requestImage函数,进行图像获取
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
private:
    //图像集合
    QHash<int, QImage> m_ImageViews;
};
#endif // IMAGEVIEW_PROVIDER_HEAD
