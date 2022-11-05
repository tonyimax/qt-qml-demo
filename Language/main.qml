import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml语言国际化")

    Column{
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 20

        Text {
            id: textLabel
            height: 60
            width: 120
            font.pointSize: 30
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("TextLabel")
            color: "#FF00FF"
        }
        Button{
            id: pushButton
            height: 60
            width: 120
            font.pointSize: 30
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("PushButton")
        }

        Column{
            anchors.right: parent.right
            anchors.rightMargin: 20

            RadioButton{
                id: enChk
                text: qsTr("English")
                checked: true
                onClicked: {
                    Language.setLanguage(0);//调用C++注册的对象方法进行切换语言
                }
            }
            RadioButton{
                id: cnCHK
                text: qsTr("简体中文")
                onClicked: {
                    Language.setLanguage(1);//调用C++注册的对象方法进行切换语言
                }
            }
        }
    }
}
