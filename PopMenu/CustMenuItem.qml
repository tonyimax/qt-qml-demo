import QtQuick 2.12
import QtQuick.Controls 2.12

MenuItem {
    id: menuCtl
    width: parent.width
    property string menuText: "Menu1" //默认菜单文字
    property string iconFile: "qrc:/images/online.png" //菜单默认图标
    property int iconSize: 50
    anchors.left: parent.left
    text: qsTr(menuText)
    font.pixelSize: 38
    height: iconSize + 20
    //菜单图标
    indicator:Image {
        id: menuIcon
        height: parent.iconSize
        width: parent.iconSize
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: parent.iconFile
    }
    //菜单文字
    contentItem: Text {
        text: menuCtl.text
        font: menuCtl.font
        opacity: enabled ? 1.0 : 0.3
        color: menuCtl.down ? "#FF00FF" : "#666666"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: menuCtl.indicator.width + 20
    }
    //菜单点击事件
    onTriggered: {idImgLoadMenu.source = menuIcon.source;window.visible = false;}
}
