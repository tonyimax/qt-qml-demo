import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 640
    title: qsTr("Qt基于Qml图片翻转演示")

    //翻转组件
    Flipable{
        id: flip
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        property bool flipped: false

        //旋转前图片
        front:Image{
            anchors.fill: parent
            source: "qrc:/images/front.png"
        }
        //旋转后图片
        back:Image{
            anchors.fill: parent
            source: "qrc:/images/back.png"
        }

        //旋转
        transform: Rotation{
            id: rotation
            origin.x: flip.width / 2
            origin.y: flip.height / 2
            axis.x: idX.checked
            axis.y: idY.checked
            axis.z: idZ.checked
            angle: 0
        }

        states:State{
            PropertyChanges {
                target: rotation
                angle:180
            }
            when:flip.flipped
        }

        //翻转动画
        transitions: Transition{
            NumberAnimation{
                target:rotation //目标
                properties: "angle"
                duration:1000
            }
        }
    }

    //下面操作按钮
    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6
        height: 30
        spacing: 10
        RadioButton{
            id: idX
            height: 24
            text: qsTr("X")
            checked: true
            background: Rectangle{
                color:"red"
                radius: 5
            }
        }

        RadioButton{
            id: idY
            height: 24
            text: qsTr("Y")
            background: Rectangle{
                color:"red"
                radius: 5
            }
        }

        RadioButton{
            id: idZ
            height: 24
            text: qsTr("Z")
            background: Rectangle{
                color:"red"
                radius: 5
            }
        }
        Button{
            height: 30
            width: 100
            text: qsTr("Flip")
            background: Rectangle{
                color:"red"
                radius: 5
            }
            onClicked: flip.flipped = !flip.flipped
        }
    }
}
