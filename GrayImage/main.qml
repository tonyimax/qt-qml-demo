import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15
ApplicationWindow {
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Qt基于Qml图片灰度处理")
    //一行放置2个图像
    Row{
        anchors.centerIn: parent
        //源图片
        Image {
            id: source
            source: "qrc:/qt.png"
            smooth: true
        }
        //修改灰度后的图片
        Image {
            id: target
            source: "qrc:/qt.png"
            smooth: true
            //处理灰度
            Desaturate {
                anchors.fill: parent //填充整个图像
                source: parent //表示图片
                desaturation: 1.0
            }
        }
    }
}
