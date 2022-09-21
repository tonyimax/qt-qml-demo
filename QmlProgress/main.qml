import QtQuick 2.7
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("基于QML实现的进度条示例")

    Column{
        width:parent.width-50
        anchors.centerIn: parent
        Rectangle{
            width: parent.width - 200
            height: parent.height
            QmlProgress {
                w:parent.width
                h:10
                progress: 68
                proBackgroundColor: "yellow"
                proColor: "red"
            }
        }

        Rectangle{
            width: parent.width - 100
            height: parent.height
            y:50
            QmlProgress {
                w:parent.width
                h:20
                progress: 68
                proBackgroundColor: "red"
                proColor: "purple"
            }
        }

        Rectangle{
            width: parent.width
            height: parent.height
            y:120
            QmlProgress {
                w:parent.width
                h:30
                progress: 68
                proBackgroundColor: "blue"
            }
        }
    }

}
