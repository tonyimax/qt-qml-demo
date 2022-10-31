import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml使用FontAwesome字体")

    Row{
        anchors.centerIn: parent
        spacing: 20

        Text{
            color: Qt.rgba(0, 160, 230, 1.0)
            font.family: "FontAwesome"
            font.pixelSize: 100
            text: "\uf00e"
        }
        Text{
            color: "green"
            font.family: "FontAwesome"
            font.pixelSize: 100
            text: "\uf004"
        }
    }
}
