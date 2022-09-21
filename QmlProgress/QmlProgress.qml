import QtQuick 2.7
import QtQuick.Controls 2.2

ProgressBar {
	property color proColor: "#148014"
	property color proBackgroundColor: "#AAAAAA"
	property int proWidth: 2
	property real progress: 0
    property real proRadius: 50
	property alias interval: timer.interval
    property int w: 500
    property int h: 50
    property bool run: true

    //取计时器状态
	function isRunning(){
		return(timer.running)
	}

    //启动计时器来更新进度值
	function onStart(){
		cProgress.progress = 0;
        timer.running = true;//通知计时器
	}

    //进度已满,停止计时器
	function onStop(){
		timer.running = false;
        //停止后重置进度,重新开始跑进度
        cProgress.progress=0;
        cProgress.onStart()
	}

	id: cProgress
    anchors.centerIn: parent
    value: (progress/100) //进度条默认值
	padding: 2
    width: w;
    height:h;

    //进度背景色
	background: Rectangle {
        implicitWidth: w
        implicitHeight: h
		color: cProgress.proBackgroundColor
        radius: cProgress.proRadius
	}

    //当前进度色
	contentItem: Item {
        implicitWidth: w
        implicitHeight: h
		Rectangle {
            width: cProgress.visualPosition * w
            height: h
            radius: cProgress.proRadius
			color: cProgress.proColor
		}
	}

	Timer{
		id: timer
        running: run //默认不启动
        repeat: true //重复使用
        interval: 50 //每50毫秒响应一次
		onTriggered:{
            cProgress.progress++;//响应进度
            if (cProgress.progress > 100){
				cProgress.onStop();
				return;
			}
		}
	}
}
