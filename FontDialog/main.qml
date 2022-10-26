import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml字体选择对话框演示")

    Button{
        anchors.centerIn: parent
        height: 48
        text: qsTr("打开字体对话框")
        MouseArea{
            anchors.fill: parent
            onClicked: {
                fontDialog.open()//打开字体选择器
            }
        }
    }

    //字体选择器
    FontDialog {
        id: fontDialog
        onAccepted: {
            console.debug(qsTr("选择的字体名称是: ") + fontDialog.currentFont.family)
            console.debug(qsTr("选择的字体大小是: ") + fontDialog.currentFont.pointSize)
        }
    }
}
