import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
ApplicationWindow {
    id:rootwindow
    visible: true
    width: 640
    height: 480
    title: qsTr("QML复制文件并显示进度")
    property string processv: ""
    Rectangle {
        id: rgProgress
        width: 500
        height:38
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 300
        Text {
            id: idCopyTips
            text: qsTr("复制文件实时速度与时间提示")
            width: 500
            height: 100
            font.pixelSize: 38
            color: "#ff00ff"
            anchors.top: pbar.top
            anchors.topMargin: 50
            anchors.right: pbar.right
        }
        // 进度条
        ProgressBar {
            id: pbar
            width: parent.width;
            height: 30
            minimumValue:  0
            maximumValue:  100
            value: 0
            style: ProgressBarStyle{
                id: progressStyle;
                background: Rectangle{
                    color: "lightgrey"
                    radius: 6
                }
                progress: Rectangle{
                    color: control.value === 100 ? "#b1d946" :"#4c7aff"
                    radius: 6
                }
                panel: Item{
                    //通过panel属性，可以加载  progress Text background等组件
                    //设置外边框
                    implicitWidth: 480;
                    implicitHeight: 15;
                    Loader{
                        anchors.fill:  parent;
                        sourceComponent: background;
                    }
                    Loader{
                        id: progressLoader;
                        anchors.top: parent.top;
                        anchors.left: parent.left;
                        anchors.bottom:  parent.bottom;
                        anchors.margins: 0;
                        z: 1;
                        width: currentProgress * (parent.width);
                        sourceComponent: progressStyle.progress;
                    }
                    Text{
                        color: "white";
                        text:(processv);
                        z: 2;
                        anchors.centerIn: parent;
                    }
                }
            }
        }
    }
    Button
    {
        width: 200
        height: 80
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        text: "选择文件"
        onClicked:
        {
           fileDialog.visible = true ;
        }
    }

    FileDialog {
        id: fileDialog
        title: "请选择一个文件"
        folder: shortcuts.desktop
        nameFilters :  [ "全部 (*)","视频 (*.flv *.mp4 *.avi *.ts *3gp *.wmv)" ]
        selectMultiple:true
        onAccepted: {
           var filepath = fileDialog.fileUrl;
           copyhelper.copyFileToDir(filepath.toString());
        }
        onRejected: {
           console.log("取消选择")
        }
        Component.onCompleted: visible = false;
    }
  Connections
  {
      target: copyhelper
      onQmlCopyProgress:
      {
         pbar.value = value;
         processv =  value + "%";
         idCopyTips.text = qsTr("每秒复制速度：") + nCopyUnit + "kb" + "剩余复制时间：" + nNeedCopyTime + "秒"
      }
  }
}
