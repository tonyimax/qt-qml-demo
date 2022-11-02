import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml选择开关示例")
    Label{
        id: label
        anchors.bottom: qmlToggleButton.top
        anchors.horizontalCenter: parent.horizontalCenter
        height: 24
        width: contentWidth
    }
    ToggleButton{
        id: idToggleButton
        anchors.centerIn: parent
        height: 38
        width: 100
        leftString: qsTr("打开")
        rightString: qsTr("关闭")
        onToggleLeft: label.text = idToggleButton.leftString
        onToggleRight: label.text = idToggleButton.rightString
    }
}
