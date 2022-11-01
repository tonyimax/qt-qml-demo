import QtQuick 2.12
import QtQuick.Controls 2.12

Page {
    id: frmWindow
    title: qsTr("MySet")
    visible: true

    property StackView stack: null

    Button {
        height: 32
        width: 120
        text: "Pop"
        anchors.left: parent.left
        anchors.top: parent.top
        onClicked: stack.pop();//出栈
    }

    Label{
        id: label
        text: qsTr("MySet")
        height: 80
        width: 240
        anchors.centerIn: parent
        font.pixelSize: 20
    }

    Button {
        height: 32
        width: 120
        text: qsTr("Account")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            page3.visible = true;
            page3.stack = stack;//设置窗口栈
            stack.push(page3);//入栈
        }
    }

    Page3 {
        id: page3
        visible: false
        stack: stack
    }
}
