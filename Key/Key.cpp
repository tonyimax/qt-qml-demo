#include "Key.h"
//构造函数
Key::Key()
{

}
//事件过滤器
bool Key::eventFilter(QObject *watched, QEvent *event)
{
    //捕获键盘按下A键事件
    if (event->type() == QEvent::KeyPress)
    {
        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(event);
        if (keyEvent->key() == Qt::Key_A)
        {
            emit sigKeyAPress();//发射A键按下信号
            return(true);
        }
    }
    //捕获键盘松开A键事件
    if (event->type() == QEvent::KeyRelease)
    {
        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(event);
        if (keyEvent->key() == Qt::Key_A)
        {
            emit sigKeyARelease();//发射A键松开信号
            return(true);
        }
    }
    //调用基类处理键盘事件
    return QObject::eventFilter(watched, event);
}
