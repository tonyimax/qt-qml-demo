#include "Language.h"
//构造函数
Language::Language(QGuiApplication &app, QQmlApplicationEngine& engine)
{
    m_app = &app;//传入app对象
    m_engine = &engine;//传入QML引擎对象
}

void Language::setLanguage(int nLanguage)
{
    QTranslator translator;//QT语言翻译库
    if (nLanguage == 0)
    {
        translator.load(":/en_US.qm");//切换英文
    }else{
        translator.load(":/zh_CN.qm");//切换中文
    }
    m_app->installTranslator(&translator);//安装语言翻译器
    m_engine->retranslate();//重新翻译界面语言
}
