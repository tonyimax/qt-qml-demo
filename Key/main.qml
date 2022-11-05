import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12

Window {
    id: frmWindow
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml全局键盘事件捕获")
    color:"black"
    Text{
        id: idShowText
        text: qsTr("键盘事件提示")
        height: 100
        width: 200
        color: "#FF00FF"
        font.pointSize: 30
        //使文本控件绝对居中
        verticalAlignment: Text.AlignVCenter 	//垂直居中，控件必须有height才可以使用
        horizontalAlignment: Text.AlignHCenter 	//水平居中，控件必须有width才可以使用
        anchors.centerIn: parent
    }

    //处理键盘按下信号
    function onSigKeyAPress(){
        idShowText.text = qsTr("按下了A键");
    }
    //处理键盘松开信号
    function onSigKeyARelease(){
        idShowText.text = qsTr("松开了A键");
    }
}
