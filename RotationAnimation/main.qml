import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt图片旋转演示基于QML RemoteDev编写")

    property bool isRotation : false //是否已旋转,默认未旋转
    //被旋转的图片组件
    Image {
        id:idImgToRatation
        height: 300
        width: 300
        anchors.centerIn: parent //居中
        source: "qrc:/image.png" //图片URL
        //鼠标点击区域
        MouseArea{
            anchors.fill: parent
            onClicked:{
                if(!idRotationAni.running){
                   idRotationAni.start();//启动旋转动画
                }
            }
        }
    }
    //旋转动画
    RotationAnimation{
        id: idRotationAni
        target: idImgToRatation //被旋转的目标
        from: 0
        to: 90
        duration: 100
        //动画结束
        onStopped: {
            //还原图片角度
            idRotationAni.from = isRotation ? 0 : 90;
            idRotationAni.to = isRotation ? 90 : 0;
            isRotation = !isRotation;
        }
    }
}
