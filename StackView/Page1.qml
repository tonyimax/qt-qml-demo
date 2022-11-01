import QtQuick 2.8
import QtQuick.Controls 2.1

Page {
    id: frmWindow
    title: qsTr("设置")
    visible: true

    property StackView stack: null

    Button {
        height: 32
        width: 120
        text: "Pop"
        anchors.left: parent.left
        anchors.top: parent.top
        onClicked: stack.pop(); //出栈
    }

    Label{
        id: label
        text: qsTr("Setting Page")
        height: 80
        width: 240
        anchors.centerIn: parent
        font.pixelSize: 20
    }

    Button {
        height: 32
        width: 120
        text: qsTr("MySet")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            page2.visible = true;
            page2.stack = stack;//设置窗口栈
            stack.push(page2);//入栈
        }
    }

    Page2 {
        id: page2
        visible: false
    }
}
