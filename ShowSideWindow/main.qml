import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
ApplicationWindow {
    id: root
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml弹出右侧弹窗演示")
    //鼠标指向图像时显出弹出窗口
    Image {
        id: image
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.top: parent.top
        anchors.topMargin: 12
        height: 36
        width: 36
        source: "qrc:/qt.png"
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                overTimer.stop();//停止定时器
                if (subWindow.visible === true) return;
                //显示弹出窗口
                subWindow.opacity = 0.0;
                subWindow.visible = true;
                downAnimation.start();
                showAnimation.start();
            }
            onExited: {
                overTimer.start();//鼠标离开图像时启动定时器
            }
        }
    }

    //定时器
    Timer{
        id: overTimer
        interval: 1000 //一秒响应一次
        repeat: false //不重复
        onTriggered: {
            //1秒后隐藏弹出窗口
            upAnimation.start();
            hideAnimation.start();
        }
    }

    //属性动画-调整弹出窗口透明度 0.0 -> 1.0 显示窗口
    PropertyAnimation{
        id: showAnimation
        target: subWindow
        properties:"opacity"
        from: 0.0
        to: 1.0
        duration: 500
    }
    //属性动画-调整弹出窗口透明度 1.0 -> 0.0 隐藏窗口
    PropertyAnimation{
        id: hideAnimation
        target: subWindow
        properties:"opacity"
        from: 1.0
        to: 0.0
        duration: 300
        onStopped: {
            subWindow.visible = false;//动画停止时隐藏窗口
        }
    }
    //属性动画-调整弹出窗口y坐标
    PropertyAnimation{
        id: downAnimation
        target: subWindow
        properties:"y"
        from: root.y
        to: root.y + 24
        duration: 300
    }

    PropertyAnimation{
        id: upAnimation
        target: subWindow
        properties:"y"
        from: root.y + 24
        to: root.y
        duration: 300
    }
    //弹出窗口组件
    ShowSideWindow{
        id: subWindow
        visible: false //默认不显示
        x: root.x + root.width + 12
        y: root.y + 24
        height: 400
        width: 200
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                overTimer.stop();//鼠标在窗口内停止定时器--显示窗口
            }
            onExited: {
                overTimer.start();//鼠标离开窗口内启动定时器--隐藏窗口
            }
        }
    }
}
