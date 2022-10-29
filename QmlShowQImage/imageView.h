#ifndef IMAGE_VIEW_HEAD
#define IMAGE_VIEW_HEAD
#include <QObject>
//图像操作私有对象
class ImageViewPrivate;
//图像提供者基类
class QQuickImageProvider;
class QmlImageView : public QObject
{
    Q_OBJECT
public:
    //构造函数
    QmlImageView();
    //多画面图像处理
    QQuickImageProvider* ImageViewMulti() const;
    //多图像源处理
    QQuickImageProvider* ImageViewSourceMulti() const;
    //开始图像源
    Q_INVOKABLE void startImageSource();
    //结束图像源
    Q_INVOKABLE void stopImageSource();
    //暂停图像源
    Q_INVOKABLE void pauseImageSource(int index);
    //恢复图像源
    Q_INVOKABLE void resumeImageSource(int index);
signals:
    //更新图像信号
    void imageViewUpdate(int index);
    //更新图像源信号
    void imageSourceUpdate(int index);
private:
    //图像提供者指针
    ImageViewPrivate * m_pImageViewPrivate = nullptr;
};
#endif //IMAGE_VIEW_HEAD
