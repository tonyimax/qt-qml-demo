import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt基于Qml的Canvas文字绘制")
    //画布
    Canvas{
        id: canvas
        width: parent.width //宽
        height: parent.height/2  //高
        //绘制信号处理
        onPaint: {
            var ctx = getContext("2d");//绘图上下文
            ctx.fillStyle = "#FF00FF";//画刷样式
            ctx.font = fontMetrics.getFont();//字体
            ctx.beginPath();//开始绘制
            ctx.text(qsTr("Qt 6 Canvas Draw text output"), 20, 40);//绘制文字
            ctx.fill();//线束绘制
        }
    }

    Text{
        id: text
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 60
        font: fontMetrics.font
        color: "red"
        text: qsTr("Qt6 Qml Text Component Output text")
    }

    FontMetrics {
        id: fontMetrics
        font.family: "Arial"
        font.pixelSize: 38
        font.italic: true
        font.bold: true

        function getFont() {
            var cssFont = fontMetrics.font.italic ? "italic " : "normal ";
            cssFont += fontMetrics.font.bold ? "bold " : "normal ";
            cssFont += (fontMetrics.font.pixelSize+"px ");
            cssFont += fontMetrics.font.family;
            return cssFont;
        }
    }
}
