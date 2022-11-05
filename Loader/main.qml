import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Window{
    width: 400
    height: 300
    visible: true
    flags: Qt.Window | Qt.WindowStaysOnTopHint
    title: qsTr("Qt基于Qml通过Loader动态加组件")
    color:"red"
    Text{
        anchors.top: parent.top
        anchors.topMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("主页面")
    }

    Button{
        height: 32
        width: 120
        anchors.centerIn: parent
        text: qsTr("下一页")
        onClicked: changePage();//调用函数加载页面
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
        onLoaded: {
           //mainWin.close();//关闭窗口
        }
    }

    function changePage(){
        pageLoader.source = "Page1.qml" //加载指定QML页面

    }
}
