import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml实现TextEdit接受拖放功能")
    //文本编辑框
    TextEdit{
        id: textEdit
        height: parent.height
        width: parent.width
        text: "拖放文件到这里"
        color: "#FF00FF"
        //拖放区域
        DropArea{
            anchors.fill: parent
            //处理拖放信号
            onDropped: {
                //拖放了多个文件
                if (drop.hasUrls){
                    for(var i = 0; i < drop.urls.length; i++){
                        textEdit.append("文件: " + drop.urls[i]); //添加文件地址到文本编辑框
                    }
                }
                else if (drop.hasText){
                    textEdit.append("文本: " + drop.text); //添加文件内容到文本编辑框
                }
            }
        }
    }
}
