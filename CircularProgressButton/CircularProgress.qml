import QtQuick 2.4
import QtQml 2.12

Canvas {
    property color arcColor: "red"
    property color arcBackgroundColor: "yellow"
    property color progressColor: "lightgreen"
    property int progressFontSize: 30
    property int arcWidth: 2
    property real progress: 0
    property real radius: 100
    property bool anticlockwise: false
    property alias interval: timer.interval

    //抛出启动与停止信号
    signal signalStartPaint()
    signal signalEndPaint()

    id: canvas
    width: 2*radius + arcWidth
    height: 2*radius + arcWidth

    Text{
        anchors.centerIn: parent
        font.pointSize: progressFontSize
        color:progressColor
        text: Math.floor((parent.progress / 360) * 100 )+ "%"
    }

    Timer{
        id: timer
        running: false
        repeat: true
        interval: 5
        onTriggered:{
            parent.progress++;
            if (parent.progress > 360){
                onStop();
                return;
            }
            parent.requestPaint(); //请求重绘
        }
    }

    function isRunning(){
        return(timer.running)
    }

    function onStart(){
        progress = 0;
        var ctx = getContext("2d");
        ctx.clearRect(0,0,width,height);
        timer.running = true;
        emit: signalStartPaint() //发射启动信号
    }

    function onStop(){
        timer.running = false;
        emit: signalEndPaint() //发射停止信号
    }

    //绘制组件
    onPaint: {
        var ctx = getContext("2d")
        ctx.clearRect(0,0,width,height)
        ctx.beginPath()
        ctx.strokeStyle = arcBackgroundColor
        ctx.lineWidth = arcWidth
        ctx.arc(width/2,height/2,radius,0,Math.PI*2,anticlockwise)
        ctx.stroke()

        var r = progress*Math.PI/180
        ctx.beginPath()
        ctx.strokeStyle = arcColor
        ctx.lineWidth = arcWidth

        ctx.arc(width/2,height/2,radius,0-90*Math.PI/180,r-90*Math.PI/180,anticlockwise)
        ctx.stroke()
    }
}



