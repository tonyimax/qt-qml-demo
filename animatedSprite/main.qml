import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true;
    width: 800;
    height: 600;
    color: "black";
    title:"Qt基于Qml图像帧动画播放"
    AnimatedSprite {
        id: animated;
        width: 365;
        height: 365;
        anchors.centerIn: parent;
        source: "qrc:/numbers.png";
        frameWidth: 64;
        frameHeight: 64;
        frameDuration: 1000; //每秒播放一帧
        frameCount: 10;
        frameX: 0;
        frameY: 0;

        onCurrentFrameChanged: {
            info.text = "%1/%2".arg(animated.currentFrame).arg(animated.frameCount);
        }
    }

    Row{
        spacing: 20;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 4;
        Text {
            id: info;
            width: 120;
            height: 60;
            color: "red";
            font.pixelSize: 38
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignRight;
        }

        Button {
            width: 120;
            height: 60;
            text: (animated.paused === true) ? "播放" : "暂停";
            onClicked: (animated.paused === true) ? animated.resume() : animated.pause();
        }

        Button {
            width: 120;
            height: 60;
            text: "单帧播放";
            onClicked: animated.advance();
        }

        Button {
            width: 120;
            height: 60;
            text: "重置";
            onClicked: animated.restart();
        }


        Button {
            width: 120;
            height: 60;
            text: "退出";
            onClicked: Qt.quit();
        }
    }
}
