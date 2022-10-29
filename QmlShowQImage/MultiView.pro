# 使用QT库
QT += quick
# C++标准
CONFIG += c++11
# 显示编译警告
DEFINES += QT_DEPRECATED_WARNINGS
# 头文件
HEADERS += \
    ImageViewProvider.h \
    imageView.h
# 源文件
SOURCES += \
        ImageViewProvider.cpp \
        imageView.cpp \
        main.cpp
# 资源
RESOURCES += qml.qrc \
    image.qrc

# QML模块导入路径
QML_IMPORT_PATH =

#  Qt Quick Designer 模块导入路径
QML_DESIGNER_IMPORT_PATH =

# 默认发布规则
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
