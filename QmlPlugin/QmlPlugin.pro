#使用qt库列表
QT += qml quick
#又c++标准
CONFIG += c++11
#生成动态链接库(dll)
TEMPLATE = lib
#定义宏
DEFINES += QTDLL_LIBRARY
//dll输出目录
DESTDIR = $$PWD/../bin/lib/
//临时文件输出目录
OBJECTS_DIR=temp/obj
UI_DIR=temp/ui
RCC_DIR=temp/rcc
MOC_DIR=temp/moc

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
HEADERS += \
    QmlPlugin.h

SOURCES += \
        QmlPlugin.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
