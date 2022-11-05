import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window{
    width: 400
    height: 300
    visible: true
    flags: Qt.Window | Qt.WindowStaysOnTopHint
    color:"black"
    Text{
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("主页二")
    }

    Button{
        height: 32
        width: 120
        anchors.centerIn: parent
        text: qsTr("下一页")
        onClicked: changePage();
    }

    Button{
        height: 32
        width: 32
        text: "X"
        anchors.right: parent.right
        anchors.rightMargin: 4
        anchors.top: parent.top
        anchors.topMargin: 4
        onClicked: {
            Qt.quit()
        }
    }

    //页面加载器
    Loader{
        id: pageLoader
    }

    function changePage(){
        pageLoader.source = "main.qml" //加载指定QML页面
        close(); //关闭窗口
    }
}  
