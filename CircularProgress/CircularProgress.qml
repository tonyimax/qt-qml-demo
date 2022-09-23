import QtQuick 2.4

//使用QT画布组件
Canvas {
    property color frontColor: "yellow" //进度条前景色
    property color backgroundColor: "#ff00ff"//进度条背景色
    property color textColor: "lightgreen"//进度条百分比文字颜色
    property int txtSize: 30 //进度条百分比文字大小
    property int itemWidth: 2 //进度条宽
    property real progress: 0 //默认进度值
    property real radius: 100 //圆角大小
    property bool anticlockwise: false
    property alias interval: timer.interval //计时器响应时间

    id: canvasProgress
    width: 2*radius + itemWidth
    height: 2*radius + itemWidth

    //中间进度百分比文字
    Text{
        anchors.centerIn: parent //在父控件中居中
        font.pointSize: txtSize //文字大小
        color:textColor //文字颜色
        text: Math.floor((parent.progress / 360) * 100 )+ "%" //进度百分比
    }

    //计时器
    Timer{
        id: timer
        running: true //默认启动计时器
        repeat: true //重复运行
        interval: 5 //每5毫秒响应一次
        onTriggered:{
            parent.progress++;//每次响应时更新进度值
            if (parent.progress > 360){
                onStop();//进度值满时停止计时器工作
                return;
            }
            parent.requestPaint();//发送父组件绘制事件,父组件会调用onPaint来进行所有绘制工作
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
    }

    function onStop(){
        timer.running = false;
        progress = 0;
        timer.running = true;
    }

    //绘制进度
    onPaint: {
        var ctx = getContext("2d") //取画布2d上下文
        ctx.clearRect(0,0,width,height)//清空画布
        ctx.beginPath()//开始路径绘制
        ctx.strokeStyle = backgroundColor //画刷颜色
        ctx.lineWidth = itemWidth //线宽
        ctx.arc(width/2,height/2,radius,0,Math.PI*2,anticlockwise) //绘制进度背景圆
        ctx.stroke()//结束绘制

        var r = progress*Math.PI/180 //当前进度值
        ctx.beginPath()//开始路径绘制
        ctx.strokeStyle = frontColor//画刷颜色
        ctx.lineWidth = itemWidth//线宽
        ctx.arc(width/2,height/2,radius,0-90*Math.PI/180,r-90*Math.PI/180,anticlockwise) //绘制进度前景圆
        ctx.stroke()///结束绘制
    }
}



