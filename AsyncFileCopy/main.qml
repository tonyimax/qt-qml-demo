import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15
import ViewModel 1.0 //c++注册的文件复制类

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Qml调用C++注册的异步文件复制")
    property string fileName: "" //文件名
    property bool interrupt : false //是否已中断
    //打开文件对话框
    FileDialog {
        id: importFileDialog
        title: "选择复制文件"
        folder: shortcuts.desktop
        selectExisting: true
        selectFolder: false
        selectMultiple: true
        modality: Qt.ApplicationModal
        nameFilters: ["所有文件 (*.*)"]
        onAccepted: {
            DataVM.copyFiles(fileUrls);//选择多个文件后，传入文件地址给文件复制类
        }
        onRejected: {
            console.log("取消了选择");
        }
    }

    //文件复制类信号连接器
    Connections{
        target: DataVM //信号目标
        //处理文件复制进度信号
        onSigCopyFileProgress:{
            progressControl.value = progress
        }
        //处理单个文件开始复制信号
        onSigOneCopyFileBegin:{
            fileNanmeTex.text = fileName
        }
        //处理所有文件复制完成信号
        onSigAllCopyFilesFinished:{
            if(interrupt)
            {
                progressControl.value = 0;
            }
            fileNanmeTex.text = ""
        }
    }


    Rectangle{
        anchors.fill: parent
        color: "#696969"

        Button{
            id:selFilesBtn
            x:100
            y:100
            width: 80
            height: 32
            hoverEnabled : true
            contentItem: Text {
                color: "black"
                text: qsTr("选择文件")
                font.pixelSize: 15
                font.family: "微软雅黑"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: {
                interrupt = false;
                importFileDialog.open();
            }
        }

        Button{
            id:interruptBtn
            x:200
            y:100
            width: 80
            height: 32
            hoverEnabled : true
            contentItem: Text {
                color: "black"
                text: qsTr("取消")
                font.pixelSize: 15
                font.family: "微软雅黑"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: {
                DataVM.interruptCopyFile();
                interrupt = true;

            }
        }

        Text {
            id: fileNanmeTex
            anchors.bottom: progressControl.top
            anchors.bottomMargin: 20
            x: progressControl.x
            text: fileName
            color: "white"
            verticalAlignment: Text.AlignVCenter
            font.family: "微软雅黑"
            font.pixelSize: 15
        }
        ProgressBar {
            id: progressControl
            value: 0.0
            x: (parent.width - progressControl.width) / 2
            y: (parent.height - progressControl.height) / 2
            width: 531
            height: 32
            //进度条背景
            background: Rectangle {
                implicitWidth: 532
                implicitHeight: 32
                color: "#FF00FF"
                radius: 5
            }
            //当前进度
            contentItem: Item {
                implicitWidth: 532
                implicitHeight: 32
                Rectangle {
                    id:progressRect
                    width: progressControl.visualPosition * parent.width;
                    height: parent.height
                    color: "yellow"
                    radius: 5
                }
            }
        }
    }
}
