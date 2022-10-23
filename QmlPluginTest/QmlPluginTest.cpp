#include "QmlPluginTest.h"
#include <QLibrary>
#include <QDebug>
#include <QCoreApplication>

QmlPluginTest::QmlPluginTest()
{

}

void QmlPluginTest::showWindow()
{
    typedef void(*FUN1)();//定义函数指针
    //加载动态库
    QLibrary lib(QCoreApplication::applicationDirPath() + "/lib/QmlPlugin.dll");

    if (lib.load()) //加载dll成功
        {
            FUN1 pShow = (FUN1)lib.resolve("ShowWindowApp");
            if (pShow) //成功找到函数
            {
                pShow();//调用函数
            }
            else //调用函数失败
            {
                qDebug() << "函数调用失败";
            }
        }
        else //加载dll失败
        {
            qDebug() << "加载dll出错";
        }
}
