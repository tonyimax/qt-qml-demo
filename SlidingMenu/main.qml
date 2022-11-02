import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt基于Qml侧边滑动菜单示例")
    property bool bMenuShown: false

    Rectangle {
        anchors.fill: parent
        color: "blue";
        opacity: bMenuShown ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: bMenuShown ? 0.5 : 1
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }

        Button {
            width: 100
            height: 48
            text: qsTr("菜单")
            onClicked: onMenu();
        }
        //动画
        transform: Translate {
            id: menuTranslate
            x: 0
            Behavior on x {
                NumberAnimation {
                    duration: 400;
                    easing.type: Easing.OutQuad
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            enabled: bMenuShown
            onClicked: onMenu();
        }
    }

    function onMenu()
    {
        menuTranslate.x = bMenuShown ? 0 : width * 0.8
        bMenuShown = !bMenuShown;
    }
}
