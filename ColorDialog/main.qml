import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1

ApplicationWindow {
    id: root
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml选择颜色对话框")
    color: colorDialog.color //选择的颜色填充窗口背景色

    //按钮
    Button{
        text: qsTr("选择颜色")
        height: 48
        width: 120
        anchors.centerIn: parent
        MouseArea{
            anchors.fill: parent
            onClicked: {
                colorDialog.open();//打开颜色选择器
            }
        }
    }

    //颜色选择器
    ColorDialog {
        id: colorDialog
        title: qsTr("SelectColor")
        color: "#FF00FF"//默认选择颜色
    }
}
