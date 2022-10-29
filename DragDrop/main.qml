import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml拖放功能实现")

    //文本拖放测试
    Text{
        id: sourceLabel
        anchors.left: parent.left
        anchors.leftMargin: 120
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr("文字内容拖放测试")

        Drag.active: dragArea.drag.active;//拖放激活
        Drag.supportedActions: Qt.CopyAction;//拖放动作-复制内容
        Drag.dragType: Drag.Automatic;//拖放类型
        Drag.mimeData: {"text": text};//拖放数据类型-文本
        //鼠标区域
        MouseArea {
            id: dragArea;
            anchors.fill: parent;
            drag.target: parent;
        }
    }

    Rectangle{
        anchors.left: sourceLabel.left
        anchors.top: sourceLabel.bottom
        anchors.topMargin: 20
        border.color: "#AAAAAA"
        border.width: 1
        height: 25
        width: 100

        TextEdit{
            id: targetEdit
            height: parent.height-2
            width: parent.width-2
            anchors.centerIn: parent
            text: qsTr("")
            //拖放区域
            DropArea {
                id: dropContainer
                anchors.fill: parent;
                //接受拖放处理
                onDropped: {
                    if (drop.supportedActions == Qt.CopyAction){
                        targetEdit.text = drop.getDataAsString("text") //赋值拖放文本给新文本对象
                    }
                }
            }
        }
    }

    //图像拖放测试
    Image{
        id: sourceImage
        height: 36
        width: 36
        anchors.right: parent.right
        anchors.rightMargin: 120
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/Face.png"

        Drag.active: dragArea1.drag.active;//拖放激活
        Drag.supportedActions: Qt.CopyAction;//拖放动作-复制内容
        Drag.dragType: Drag.Automatic;//拖放类型
        Drag.mimeData: {"pic": source};//拖放数据类型-图像
        //鼠标区域
        MouseArea {
            id: dragArea1;
            anchors.fill: parent;
            drag.target: parent;
        }
    }

    Rectangle{
        anchors.left: sourceImage.left
        anchors.top: sourceLabel.bottom
        anchors.topMargin: 20
        border.color: "#AAAAAA"
        border.width: 1
        height: 36
        width: 36

        Image{
            id: targetImage
            height: parent.height-2
            width: parent.width-2
            anchors.centerIn: parent
            //拖放区域
            DropArea {
                id: dropContainer1
                anchors.fill: parent;
                //接受拖放处理
                onDropped: {
                    if (drop.supportedActions == Qt.CopyAction){
                        targetImage.source = drop.getDataAsString("pic") //赋值拖放图像路径给新图像对象
                    }
                }
            }
        }
    }
}
