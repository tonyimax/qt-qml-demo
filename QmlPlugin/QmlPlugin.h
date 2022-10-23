#pragma once

#include <QQmlApplicationEngine>
#include <QtCore/qglobal.h>
//导入导出宏定义
#if defined(QTDLL_LIBRARY)
#  define QTDLLSHARED_EXPORT Q_DECL_EXPORT
#else
#  define QTDLLSHARED_EXPORT Q_DECL_IMPORT
#endif
//导出类
class QTDLLSHARED_EXPORT QmlPlugin
{
public:
    void ShowWindow();//类函数
private:
    QQmlApplicationEngine engine;//qml引擎对象
};

extern "C" QTDLLSHARED_EXPORT void ShowWindowApp(); //定义导出函数
