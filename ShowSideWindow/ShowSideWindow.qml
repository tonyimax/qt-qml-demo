import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window {
    flags: Qt.FramelessWindowHint  //无标题窗口
    color: "#FF00FF"
    Text {
        id: info
        text: qsTr("弹出窗口显示的信息")
    }
}
