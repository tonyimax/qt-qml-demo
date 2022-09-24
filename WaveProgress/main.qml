import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    color:"black" //窗口背景
    title: qsTr("QT定制波浪进度条基于QML")

    property int rangeValue: 68; //水波浪最大进度值
    property int nowRange: 0;//水波浪默认进度值

    //画布大小与画布边框大小
    property int w: 250;//宽
    property int h: 250;//高
    property int lineWidth: 2;//边框

    //圆
    property double r: h / 2; //圆垂直方向中心
    property double cR: r - 16 * lineWidth; //圆半径

    //Sin曲线
    property int sX: 0;
    property int sY: h / 2;
    property int axisLength: w;        //轴长
    property double waveWidth: 0.015;   //波浪宽度,数越小越宽
    property double waveHeight: 6;      //波浪高度,数越大越高
    property double speed: 0.09;        //波浪速度，数越大速度越快
    property double xOffset: 0;         //波浪x偏移量

    Canvas{
        id: canvas
        width: w
        height: h
        anchors.centerIn: parent
        onPaint: {
            var ctx = getContext("2d");//取得2d绘图上下文
            ctx.clearRect(0, 0, w, h);//清空区域
            //绘制进度条外圈
            ctx.beginPath();//开始绘制
            ctx.strokeStyle = 'red';
            ctx.arc(r, r, cR+5, 0, 2*Math.PI);
            ctx.stroke();//结束绘制


            ctx.beginPath();
            ctx.arc(r, r, cR, 0, 2*Math.PI);
            ctx.clip();

            //绘制sin曲线
            ctx.save();
            var points=[];
            ctx.beginPath();
            for(var x = sX; x < sX + axisLength; x += 20 / axisLength){
                var y = -Math.sin((sX + x) * waveWidth + xOffset);
                var dY = h * (1 - nowRange / 100 );
                points.push([x, dY + y * waveHeight]);
                ctx.lineTo(x, dY + y * waveHeight);
            }

            //绘制波浪
            ctx.lineTo(axisLength, h);
            ctx.lineTo(sX, h);
            ctx.lineTo(points[0][0],points[0][1]);
            ctx.fillStyle = '#ff00ff';
            ctx.fill();
            ctx.restore();

            //绘制百分数文字
            ctx.save();
            var size = 0.4*cR;
            ctx.font = size + 'px Arial';//字体大小
            ctx.textAlign = 'center';//居中
            ctx.fillStyle = "rgba(255, 255, 255, 0.8)";//字体颜色
            ctx.fillText(~~nowRange + '%', r, r + size / 2);//根据进度显示文本
            ctx.restore();

            //增加Rang值
            if(nowRange <= rangeValue){
                nowRange += 1;
            }

            if(nowRange > rangeValue){
                nowRange -= 1;
            }
            xOffset += speed;
        }

        Timer{
            id: timer
            running: true //默认启动计时器
            repeat: true //重复
            interval: 5 //计时器响应时间
            onTriggered:{
                parent.requestPaint();//请求窗口重新绘制,窗口会调用onPaint函数
            }
        }
    }

}
