import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    id:applicationWindow
    visible: true
    width: 400
    height: 300
    title: qsTr("插件测试窗口")

    Button{
        id:button
        text: qsTr("调用dll插件中的窗口")
        height:48
        width:250
        anchors.centerIn: parent
        MouseArea{
            id:mouseArea
            anchors.fill: parent
            onPressed: {
                qmlPluginTest.showWindow();
            }
        }
    }
}
