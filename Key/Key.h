#include <QObject>
#include <QEvent>
#include <QKeyEvent>
//键盘事件类
class Key : public QObject
{
    Q_OBJECT
public:
    //构造
    Key();
protected:
    //重写事件过滤器虚函数
    virtual bool eventFilter(QObject *watched, QEvent *event);
signals:
    void sigKeyAPress();//按下A键信号
    void sigKeyARelease();//松开A键信号
};
