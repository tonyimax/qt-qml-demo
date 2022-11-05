import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml文本字段编辑完成事件处理")
    //鼠标点击窗口任意位置
    MouseArea{
        anchors.fill: parent
        onClicked: {
            textField.textFieldEditFinished();//发射编辑完成信号
        }
    }
    //保存文本用的TextMetrics
    TextMetrics {
        id: textMetrics
        elide: Text.ElideRight
        elideWidth: textField.width - 12
        text: qsTr("保存文本的TextMetrics")
    }
    //文本字段
    TextField{
        id: textField
        text: textMetrics.elidedText
        height: 32
        width: 120
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment:Text.AlignLeft
        selectByMouse: true
        signal textFieldEditFinished //编辑完成信号
        //背景
        background: Rectangle {
            id: textFieldback
            implicitWidth: 120
            implicitHeight: 32
            border.color:  "#FF00FF"
            visible: false
            radius: 5
        }
        //鼠标按下时信号
        onPressed:{
            textFieldback.visible = true;//显示边框
            textField.text = textMetrics.text;//填充字段内容
        }
        //文本字段编辑完成信号--按下回车键时
        onEditingFinished :{
            textField.textFieldEditFinished();//发射编辑完成信号
        }
    }

    //信号连接器
    Connections{
        target: textField
        //处理文本字段发出的编辑完成
        onTextFieldEditFinished:{
            //处理编辑完事业务
            if (textFieldback.visible !== true) return;
            textFieldback.visible = false;//隐藏文本字段边框
            textField.focus = false;//取消焦点
            textMetrics.text = textField.text;//保存文本段的内容
            textField.text = textMetrics.elidedText;//超出文本显示...
        }
    }
}
