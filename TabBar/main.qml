import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

ApplicationWindow {
    id: frmWindow
    visible: true
    width: 600
    height: 800
    title: qsTr("Qt基于Qml实现底部导航栏(TabBar)")

    footer:Rectangle{
        color:"blue"
        height:80
        BaseTabBar{
        id: bar
        height: 80
        width: parent.width
        anchors.bottom: parent.bottom
        Component.onCompleted: {
            myModel.append({ "modelText": "消息", "modelColor": "red", "modelColorG": "#148014",
                               "modelSrc": "qrc:/images/Chat_MsgRecord.svg", "modelSrcG": "qrc:/images/Chat_MsgRecordG.svg"})
            myModel.append({ "modelText": "联系人", "modelColor": "red", "modelColorG": "#148014",
                               "modelSrc": "qrc:/images/Chat_FriendManager.svg", "modelSrcG": "qrc:/images/Chat_FriendManagerG.svg"})
            myModel.append({ "modelText": "发现", "modelColor": "red", "modelColorG": "#148014",
                               "modelSrc": "qrc:/images/Mobile_Find.svg", "modelSrcG": "qrc:/images/Mobile_FindG.svg"})
            myModel.append({ "modelText": "我", "modelColor": "red", "modelColorG": "#148014",
                               "modelSrc": "qrc:/images/Main_P2PChat.svg", "modelSrcG": "qrc:/images/Main_P2PChatG.svg"})
        }
    }
    }


    SwipeView {
        id: view
        height: frmWindow.height - 120
        width: parent.width
        currentIndex: bar.currentIndex
        anchors.top: topbar.bottom

        Rectangle{
            color:"red"
            Text {
                text: qsTr("消息")
                color:"white"
                font.pixelSize: 30
                anchors.centerIn: parent
            }
        }
        Rectangle{
            color:"green"
            Text {
                text: qsTr("联系人")
                color:"white"
                font.pixelSize: 30
                anchors.centerIn: parent
            }
        }
        Rectangle{
            color:"blue"
            Text {
                text: qsTr("发现")
                color:"white"
                font.pixelSize: 30
                anchors.centerIn: parent
            }
        }
        Rectangle{
            color:"yellow"
            Text {
                text: qsTr("我")
                color:"red"
                font.pixelSize: 30
                anchors.centerIn: parent
            }
        }
    }
}
