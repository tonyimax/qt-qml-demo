import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml调用C++写日志实现")
    //组件渲染完成后直接写日志
    Component.onCompleted: {
        log4Qml.qDebug_Info(0, "Qt基于Qml调用C++写日志实现");//写日志到文件
        log4Qml.qDebug_Info(1, "Qt基于Qml调用C++写日志实现");//写日志到文件
        log4Qml.qDebug_Info(2, "Qt基于Qml调用C++写日志实现");//写日志到文件
        log4Qml.qDebug_Info(3, "Qt基于Qml调用C++写日志实现");//写日志到文件
    }
}
