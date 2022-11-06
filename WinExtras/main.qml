import QtQuick 2.12
import QtQuick.Controls 2.12
import QtWinExtras 1.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml之WinExtras实现")
    //任务样按钮
    TaskbarButton {
        property real proValue: 0
        property alias interval: timer.interval

        function isRunning(){
            return(timer.running)
        }

        function onStart(){
            taskbar.proValue = 0;
            timer.running = true;
        }

        function onStop(){
            timer.running = false;
        }

        id: taskbar
        overlay.iconSource: "qrc:/qt.ico"
        overlay.accessibleDescription: qsTr("加载中...")
        progress.visible: (progress.value != 0)
        progress.value: taskbar.proValue

        Timer{
            id: timer
            running: false
            repeat: true
            interval: 20
            onTriggered:{
                taskbar.proValue++;
                if (taskbar.proValue > 100){
                    taskbar.onStop();
                    return;
                }
            }
        }
    }

    Button{
        id: btnTaskbar
        height: 24
        width: 120
        anchors.centerIn: parent
        text: taskbar.isRunning() ? qsTr("End") : qsTr("Start")
        onClicked: {
            if (taskbar.isRunning()){
                taskbar.onStop();
            }else{
                taskbar.onStart();
            }
        }
    }
    //程序任务栏缩略窗口工具栏
    ThumbnailToolBar {
        ThumbnailToolButton {
            iconSource: "qrc:/resources/icons/Record.svg"
            tooltip: qsTr("Record")
        }
        ThumbnailToolButton {
            iconSource: "qrc:/resources/icons/Friend.svg"
            tooltip: qsTr("Friend")
        }
        ThumbnailToolButton {
            iconSource: "qrc:/resources/icons/Mobile.svg"
            tooltip: qsTr("Mobile")
        }
        ThumbnailToolButton {
            iconSource: "qrc:/resources/icons/Main.svg"
            tooltip: qsTr("Main")
            onClicked: {
                Qt.quit()
            }
        }
    }
}
