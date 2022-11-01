import QtQuick 2.12
import QtQuick.Controls 2.12
ApplicationWindow {
    id: frmWindow
    title: qsTr("Qt基于Qml堆栈(StackView)窗口使用示例")
    width: 400
    height: 300
    visible: true
    //窗口栈
    StackView {
        id: stack
        initialItem: mainView
        anchors.fill: parent
    }

    Page {
        id: mainView

        Label{
            text: qsTr("Home")
            height: 80
            width: 240
            anchors.centerIn: parent
            font.pixelSize: 20
        }
        Button {
            height: 32
            width: 120
            text: qsTr("Setting")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            onClicked: {
                page1.visible = true;
                page1.stack = stack;//设置页面栈
                stack.push(page1);//入栈
            }
        }
    }

    Page1 {
        id: page1
        visible: false
    }
}
