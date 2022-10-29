#include "imageView.h"
#include "ImageViewProvider.h"

#include <QGuiApplication>
#include <QMovie>
#include <QPixmap>
#include <QScreen>
#include <QTimer>
#include <QDebug>

class ImageViewPrivate
{
public:
    //构造函数
    ImageViewPrivate() {
        //实例化对象
        m_pImageViewProviderMulti = new ImageViewProvider;
        m_pImageViewProviderMultiSource = new ImageViewProvider;
    }
    //图像提供者对象指针
    ImageViewProvider * m_pImageViewProviderMulti = nullptr; //用于多画面
    ImageViewProvider * m_pImageViewProviderMultiSource = nullptr;//用于多图像源
    //计时器指针
    QTimer * m_pTimer = nullptr;
    //影像指针
    QMovie * m_pMovies[4] = { nullptr };
};

//构造图像
QmlImageView::QmlImageView()
{
    m_pImageViewPrivate = new ImageViewPrivate;
    m_pImageViewPrivate->m_pTimer = new QTimer(this);
    //连接计时器信号
    connect(m_pImageViewPrivate->m_pTimer, &QTimer::timeout, this, [this]() {
        static int index = 0;
        //抓图
        QImage objImage = QGuiApplication::primaryScreen()->grabWindow(0).toImage();
        //更新图像
        m_pImageViewPrivate->m_pImageViewProviderMulti->updateImageView(index,objImage);
        //发射更新信号
        emit imageViewUpdate(index);
        if (++index == 9) index = 0;
    });
    //每秒抓9张
    m_pImageViewPrivate->m_pTimer->start(1000 / 9);

    //多图像源处理
    for (int i = 0;  i < 4; i++) {
        m_pImageViewPrivate->m_pMovies[i] =  new QMovie(":/" + QString::number(i) + ".gif", "GIF", this);
        //调试输出
        qDebug() << m_pImageViewPrivate->m_pMovies[i]->fileName() << m_pImageViewPrivate->m_pMovies[i]->isValid();
        //连接动画帧变更信号
        connect(m_pImageViewPrivate->m_pMovies[i], &QMovie::frameChanged, this, [i, this](int) {
            //更新图像
            m_pImageViewPrivate->m_pImageViewProviderMultiSource->updateImageView(i,
                                       m_pImageViewPrivate->m_pMovies[i]->currentImage());
            //发射更新信号
            emit imageSourceUpdate(i);
        });
    }
}

//多画面图像处理
QQuickImageProvider* QmlImageView::ImageViewMulti() const
{
    return m_pImageViewPrivate->m_pImageViewProviderMulti;
}
//多图像源处理
QQuickImageProvider* QmlImageView::ImageViewSourceMulti() const
{
    return m_pImageViewPrivate->m_pImageViewProviderMultiSource;
}

//开始图像源
void QmlImageView::startImageSource()
{
    if (m_pImageViewPrivate->m_pTimer)
        m_pImageViewPrivate->m_pTimer->stop();

    for (auto it : m_pImageViewPrivate->m_pMovies) {
        if (it) it->start();
    }
}
//结束图像源
void QmlImageView::stopImageSource()
{
    if (m_pImageViewPrivate->m_pTimer) m_pImageViewPrivate->m_pTimer->start(1000 / 9);

    for (auto it : m_pImageViewPrivate->m_pMovies) {
        if (it) it->stop();
    }
}
//暂停图像源
void QmlImageView::pauseImageSource(int index)
{
    if (m_pImageViewPrivate->m_pMovies[index]) m_pImageViewPrivate->m_pMovies[index]->setPaused(true);
}
//恢复图像源
void QmlImageView::resumeImageSource(int index)
{
    if (m_pImageViewPrivate->m_pMovies[index]) m_pImageViewPrivate->m_pMovies[index]->setPaused(false);
}


