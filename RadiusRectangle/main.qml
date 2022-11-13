import QtQuick 2.12
import QtQuick.Window 2.12
Window {
    width: 800
    height: 640
    visible: true
    title: qsTr("Qt基于Qml任意圆角矩形定制")
    color:"black"
    //测试组件
    Row{
        id:idRow
        spacing: 20
        anchors.centerIn: parent
        property int w: 180
        property int h: 180
        property var colors :["red","#FF00FF","#00FFFF","orange"]
        RadiusRectangle{
            width: parent.w
            height: parent.h
            color: parent.colors[0]
            cornersRadius: [20,0,20,0]
            borderWidth:1
            borderColor:"yellow"
        }
        RadiusRectangle{
            width: parent.w
            height: parent.h
            color: parent.colors[1]
            cornersRadius: [30,50,40,0]

        }
        RadiusRectangle{
            width: parent.w
            height: parent.h
            color: parent.colors[2]
            cornersRadius: [30,0,0,30]
        }
        RadiusRectangle{
            width: parent.w
            height: parent.h
            color: parent.colors[3]
            cornersRadius: [0,20,20,0]
        }
    }
}

