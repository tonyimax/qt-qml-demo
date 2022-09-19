import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("基于QT的QML编程的等待指示器-RemoteDev编写")

    RemoteDevBusyIndicator{nSize:300;from:"red";to:"yellow"}
    RemoteDevBusyIndicator{nSize:180;from: "blue";to:"purple"}
    RemoteDevBusyIndicator{nSize:100;from:"#80c342";to: "#006325"}
}
