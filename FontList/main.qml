import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
ApplicationWindow {
    id: root
    visible: true
    width: 600
    height: 600
    title: qsTr("Qt基于Qml获取系统字体列表")
    color: "black"

    property string fontName: "Microsoft Yahei"
    //字体列表组件
    FontList{
        id: fontList
        height: 400
        width: 400
        visible: false
        onSClick: {
            console.log(sFontName)
            fontName = sFontName;
        }
    }

    Rectangle{
        id: fontSelect
        height: 24
        width: txtShow.width + txtShow.anchors.leftMargin + txtFont.width + txtFont.anchors.leftMargin + 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: "#AAAAAA"
        border.width: 1

        Text {
            id: txtShow
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Select Font 选择字体")
            font.family: fontName
            font.pixelSize: 14
        }

        Text {
            id: txtFont
            anchors.left: txtShow.right
            anchors.leftMargin: 6
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            text: fontName
            font.pixelSize: 14
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                fontList.visible = !fontList.visible;
            }
        }
    }
}
