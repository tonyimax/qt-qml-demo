import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQml 2.12

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt弹出菜单演示基于QML")
    //鼠标点击区域
    MouseArea{
        anchors.fill: parent
        onClicked:{
            window.visible = false //点击窗口任何地方隐藏菜单
        }
    }
    //被点击的图片组件
    Image {
        id: idImgLoadMenu
        width: 50
        height: 50
        source: "qrc:/images/online.png"
        //左上布局
        anchors.top:parent.top
        anchors.topMargin: 50
        anchors.left:parent.left
        anchors.leftMargin: 50
        MouseArea{
            id: mouseArea
            anchors.fill: parent;
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked:{
                window.visible = mouse.button ===Qt.LeftButton //点击鼠标左键显示窗口,右键隐藏窗口
                if(window.visible) {menu.open()}//每次点击都加载菜单
            }
        }
    }

    Rectangle {
        id: window
        width: 400
        height: menu.height
        anchors.left: idImgLoadMenu.right
        anchors.leftMargin: 10
        anchors.top: idImgLoadMenu.top
        Menu{
            id: menu
            width: parent.width
            background: Rectangle{
                radius: 5
                border.color: "#999999"
                border.width: 1
            }
            CustMenuItem{
                id:m1
                menuText: "在线"
                iconFile: "qrc:/images/online.png"
            }
            CustMenuItem{
                id:m2
                menuText: "离开"
                iconFile: "qrc:/images/away.png"
            }
            CustMenuItem{
                id:m3
                menuText: "忙碌"
                iconFile: "qrc:/images/busy.png"
            }
            CustMenuItem{
                id:m4
                menuText: "隐身"
                iconFile: "qrc:/images/hide.png"
            }
        }
   }
}
