#pragma once
#include <QObject>

class QmlPluginTest : public QObject
{
    Q_OBJECT
public:
    QmlPluginTest();

    Q_INVOKABLE void showWindow();
};
