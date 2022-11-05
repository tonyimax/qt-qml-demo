QT += qml quick
CONFIG += c++11
SOURCES += main.cpp \
    Language.cpp
RESOURCES += qml.qrc
# 语言国际化资源
TRANSLATIONS = zh_CN.ts en_US.ts
HEADERS += \
    Language.h
