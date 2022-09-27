import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt定制带圆形进度按钮基于QMl")
    color: "black"
    Rectangle{
        property int btnHeight: 200
        property int btnWidth: 500

        id: idCircularProgressButton
        height: btnHeight
        width: btnWidth
        color: "black"
        anchors.centerIn: parent
        border.color: "#ff00ff"
        border.width: 2
        radius: 5
        Text{
            id: cText
            anchors.centerIn: parent
            font.family: "microsoft yahei"
            font.pixelSize: 30
            color:"white"
            text: qsTr("Start")
        }
        MouseArea{
            anchors.fill: parent
            //点击按钮时隐藏文本播放属性
            onClicked: {
                if (rAniStart.running || rAniStop.running) return
                cText.visible = false;
                rAniStart.start();
                widthAniStart.start();
            }
        }
        PropertyAnimation{
            id: rAniStart
            target: idCircularProgressButton
            property: "radius"
            duration: 300
            from: 0
            to: idCircularProgressButton.btnHeight/2
            //动画停止后显示进度条
            onStopped: {
                cProgress.onStart();
                cProgress.visible = true;
            }
        }
        PropertyAnimation{
            id: widthAniStart
            target: idCircularProgressButton
            property: "width"
            duration: 300
            from: idCircularProgressButton.btnWidth
            to: idCircularProgressButton.btnHeight
        }
        CircularProgress{
            id: cProgress
            anchors.centerIn: parent
            visible: false
            arcWidth: 2
            radius: idCircularProgressButton.btnHeight/2
            interval: 10
            arcColor: "#ff00ff"
            //处理停止信号,隐藏圆形进度条
            onSignalEndPaint: {
                visible = false;
                rAniStop.start();
                widthAniStop.start();
            }
            onSignalStartPaint: {
                console.log("进度条绘制开始...")
            }
        }
        PropertyAnimation{
            id: rAniStop
            target: idCircularProgressButton
            property: "radius"
            duration: 300
            from: idCircularProgressButton.btnHeight/2
            to: 0
            //动画播放停止后停发按钮文本与文本颜色
            onStopped: {
                cText.text = qsTr("End");
                cText.color = "#148014"
                cText.visible = true;
            }
        }
        PropertyAnimation{
            id: widthAniStop
            target: idCircularProgressButton
            property: "width"
            duration: 300
            from: idCircularProgressButton.btnHeight
            to: idCircularProgressButton.btnWidth
        }
    }
}
