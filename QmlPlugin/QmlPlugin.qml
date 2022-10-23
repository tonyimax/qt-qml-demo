import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id:idExportPluginWindow
    visible: true
    width: 800
    height: 640
    title: qsTr("导出的dll插件窗口")

    Button{
        id:idExportBtnContrl
        text: qsTr("dll插件窗口中的按钮控件")
        height:100
        width:parent.width
        font.pointSize: 38
        anchors.centerIn: parent
        MouseArea{
            id:mouseArea
            anchors.fill: parent
            onPressed: {
               idExportPluginWindow.title = "点击了插件窗口的按钮";
            }
        }
    }
}
