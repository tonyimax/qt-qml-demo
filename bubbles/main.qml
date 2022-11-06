import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Particles 2.0

Window {
    visible: true;
    width: 600;
    height: 400;
    color: "lightblue";
    id: root;
    title:"Qt基于Qml材质系统ParticleSystem使用示例"
    Rectangle {
        id: target;
        color: "transparent";//透明色
        width: parent.width/2;
        height: 100;
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: 4;
    }
    //材质系统
    ParticleSystem {id: particleSystem}
    //发射器
    Emitter {
        id: emitter;
        system: particleSystem;//指定材质系统
        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
        width: 80;
        height: 80;
        size: 20;
        endSize: 80;
        sizeVariation: 10;
        emitRate: 20;//发射率
        lifeSpan: 4000;
        lifeSpanVariation: 200;
        velocity: TargetDirection {
            targetItem: target;
            targetX: target.width/2;
            targetY: 0;
            targetVariation: target.width/2;
            magnitude: root.height/3;
        }
    }
    //图片材质
    ImageParticle {
        system: particleSystem;
        source: "qrc:/bubble_1.png";
    }
}
