QT += qml quick
CONFIG += c++11
DESTDIR = $$PWD/../bin/
OBJECTS_DIR=temp/obj
UI_DIR=temp/ui
RCC_DIR=temp/rcc
MOC_DIR=temp/moc
SOURCES += main.cpp \
    QmlPluginTest.cpp
HEADERS += \
    QmlPluginTest.h
RESOURCES += qml.qrc
