import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt定制CheckBox控件基于QML")

    CheckBox {
        id: checkBox
        text: qsTr("记住密码自动登录")
        checked: true
        anchors.centerIn: parent
        spacing: 0
        font.pointSize: 24
        enabled: true
        //选中指示图片
        indicator:Image {
              id: image
              height: 38
              width: 38
              anchors.verticalCenter: parent.verticalCenter
              source: checkBox.checked ? "qrc:/images/checked.png" : "qrc:/images/unchecked.png"
        }
        //文本
        contentItem: Text {
            id: text
            text: checkBox.text //文本内容
            font: checkBox.font //字体大小
            opacity: enabled ? 1.0 : 0.3 //文本透明度
            color: checkBox.checked ? "#148014" : "#303303" //文本颜色
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            leftPadding: checkBox.indicator.width + checkBox.spacing
        }
    }
}
