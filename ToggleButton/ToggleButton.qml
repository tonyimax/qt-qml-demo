import QtQuick 2.12

Rectangle {
    id: root
    width: 80
    height: 26
    color: "#EAEAEA"
    radius: 13

    property string leftString
    property string rightString
    signal toggleLeft //左开关信号
    signal toggleRight //右开关信号

    Rectangle {
        id: rect
        width: parent.width * 0.6
        radius: parent.radius
        color: rect.state === "left"? "#FF00FF" : "#CCCCCC" //根据状态切换背景色
        state: "left"
        anchors {
            top: parent.top
            bottom: parent.bottom
        }

        states: [
            State {
                name: "right"
                PropertyChanges {
                    target: rect
                    x: root.width - rect.width
                }
            }

        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { property: "x"; duration: 200 }
            }
        ]

        Text {
            id: label
            anchors.centerIn: parent
            text: rect.state === "left"? root.leftString : root.rightString
            color: "white"
            font.pointSize: 10
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            //点开切换状态
            if(rect.state === "left"){
                rect.state = "right";
                root.toggleRight();
            }else {
                rect.state = "left";
                root.toggleLeft();
            }
        }
    }
}
