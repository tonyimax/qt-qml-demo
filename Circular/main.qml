import QtQuick 2.12
import QtQuick.Controls 2.12


ApplicationWindow {
    id:mainWidnow
    title: qsTr("Qt基于Qml圆形头像定制")
    width: 800
    height: 600
    visible: true
    color: "black"
    CircularItem{anchors.centerIn: parent}
}
