import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.0
import ViewModel 1.0

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("异步文件复制")

    property string fileName: ""
    property bool interrupt : false


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
            DataVM.copyFiles(fileUrls)
        }
        onRejected: {
            console.log("fileDialog rejected");
        }
    }


    Connections{
        target: DataVM
        onSigCopyFileProgress:{
            progressControl.value = progress
        }
        onSigOneCopyFileBegin:{
            fileNanmeTex.text = fileName
        }
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

            background: Rectangle {
                implicitWidth: 532
                implicitHeight: 32
                color: "#3692F0"
            }

            contentItem: Item {
                implicitWidth: 532
                implicitHeight: 32
                Rectangle {
                    id:progressRect
                    width: progressControl.visualPosition * parent.width;
                    height: parent.height
                    //color: "red"
                    color: "#00BAFF"
                }
            }
        }
    }



}
