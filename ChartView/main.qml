import QtQuick 2.12
import QtQuick.Controls 2.12
import QtCharts 2.3

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt基于Qml图饼定制演示")

    ChartView {
        anchors.fill: parent
        //theme: ChartView.ChartThemeQt  //使用样式的话 backgroundColor无效
        antialiasing: true
        legend.visible: false
        animationOptions: ChartView.AllAnimations
        backgroundColor: "black"
        titleColor: "white"
        title: "Qml ChartView "
        PieSeries {
            id: pieSeries
            PieSlice {
                borderColor: "#AAAAAA"
                color: "#00FF00"
                label: qsTr("C++")
                labelVisible: true
                value: 56.6
                labelColor: "green"
            }
            PieSlice {
                borderColor: "#AAAAAA"
                color: "#FF00FF"
                label: qsTr("C#")
                labelVisible: true
                value: 30
                labelColor: "red"
            }
            PieSlice {
                borderColor: "#AAAAAA"
                color: "#FFFF00"
                label: qsTr("QML")
                labelVisible: true
                value: 13.4
                labelColor: "blue"
            }
        }
    }
}
