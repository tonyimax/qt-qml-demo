#pragma once
#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
class Language : public QObject
{
    Q_OBJECT
public:
    //构造函数
    Language(QGuiApplication& app, QQmlApplicationEngine &engine);
    //注册供QML使用的setLanguage函数
    Q_INVOKABLE void setLanguage(int nLanguage);
private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};
