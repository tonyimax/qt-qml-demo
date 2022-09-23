import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt带百分比的圆形进度条演示")
    color:"black"
    //使用定制的进度条组件
    CircularProgress{
        id: cProgress
        anchors.centerIn: parent
        itemWidth: 3 //进度条宽
        radius: 100 //圆角宽
        interval: 10 //计时器响应时间
    }
}
