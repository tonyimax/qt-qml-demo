import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 400
    height: 400
    title: qsTr("Qt基于Qml超链接使用")

    Rectangle {
        width: 100
        height: 50
        anchors.centerIn: parent
        color: "lightblue"
        radius: 10
        Text {
            anchors.centerIn: parent
            text: '<html></style><a href="https://blog.csdn.net/fittec">打开CSDN</a></html>'
            MouseArea {
               anchors.fill: parent;
               hoverEnabled: true;//鼠标在控件范围内
               cursorShape: (containsMouse? Qt.PointingHandCursor: Qt.ArrowCursor);//显示手式鼠标
               onClicked: Qt.openUrlExternally("https://blog.csdn.net/fittec") //打开URL
           }
        }

    }
}
