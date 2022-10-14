import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
ApplicationWindow {
    id:rootwindow
    visible: true
    width: 1920
    height: 600
    title: qsTr("QML复制文件并显示进度与百分比")
    property string processv: ""
    Rectangle {
        id: rgProgress
        width: parent.width - 20
        height: 200
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 300
        // 进度条
        ProgressBar {
            id: pbar
            width: parent.width ;
            height: parent.height;
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
        width: 100
        height: 50
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
        title: "Please choose a file"
        folder: shortcuts.desktop
        nameFilters :  [ "video file (*.mp4 *.avi *.ts *3gp *.wmv)", "All files (*)" ]
        selectMultiple:true
        onAccepted: {
           var filepath = fileDialog.fileUrl;
           console.log("file--",filepath);
           copyhelper.copyfiletoDir(filepath.toString())
        }
        onRejected: {
           console.log("cancel")

        }
        Component.onCompleted: visible = false;
    }
  Connections
  {
      target: copyhelper
      //更新复制进度
      onQml_copy_pro:
      {
           pbar.value = provalu;
           processv =  provalu + "%";
      }

  }

}
