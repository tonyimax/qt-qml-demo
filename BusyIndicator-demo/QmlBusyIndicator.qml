import QtQuick 2.7
import QtGraphicalEffects 1.0 //ConicalGradient组件所在类

Item {
    property string fromColor :  "#80c342"
    property string toColor : "#006325"
    Rectangle {
        id: rect //组件ID
        width: parent.width //宽
        height: parent.height //高
        color: Qt.rgba(0, 0, 0, 0) //背景色
        radius: width / 2  //圆角大小
        border.width: width / 6 //边框宽
        border.color: fromColor //边框颜色
        visible: true //组件可见
    }

    //渐变区域
    ConicalGradient {
        width: rect.width //宽
        height: rect.height //高
        gradient: Gradient {
            GradientStop { position: 0.0; color: fromColor}//渐变开始颜色
            GradientStop { position: 1.0; color: toColor}//渐变结束颜色
        }
        source: rect //目标渐变区域
        //转动的圆点
        Rectangle {
            width: rect.border.width //宽
            height: width  //高
            radius: width / 2  //圆角
            color: toColor  //颜色
            anchors.top: parent.top //顶部与父组件对齐
            anchors.horizontalCenter: parent.horizontalCenter//在父组件中水平居中
        }

        //旋转动画
        RotationAnimation on rotation {
            from: 0  //开始旋转角度
            to: 360  //结束旋转角度
            duration: 800 //旋转频率
            loops: Animation.Infinite //无限循环
        }
    }
}
