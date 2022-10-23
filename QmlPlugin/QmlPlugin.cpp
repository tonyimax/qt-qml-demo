#include "QmlPlugin.h"
//类成员函数实现
void QmlPlugin::ShowWindow()
{
    engine.load(QUrl(QLatin1String("qrc:/QmlPlugin.qml")));//加载qml资源
}
//导出函数实现
void ShowWindowApp()
{
    QmlPlugin *pPlugin = new QmlPlugin;//实例化类对象
    pPlugin->ShowWindow();//调用类成员函数加载qml资源并显示窗口
}
