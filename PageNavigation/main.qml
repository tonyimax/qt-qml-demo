import QtQuick 2.12
import QtQuick.Controls 2.12
ApplicationWindow {
    visible: true
    width: 860
    height: 300
    title: qsTr("Qt基于Qml实现分页控件")
    //显示已选中页码
    Text {
        id: txtPage
        anchors.bottom: pageNavigation.top
        anchors.bottomMargin: 20
        anchors.horizontalCenter: pageNavigation.horizontalCenter
        font.family: "microsoft yahei"
        font.pixelSize: 20
        text: qsTr("第1页")
        color: "#FF00FF"
    }
    //使用分页控件
    PageNavigation{
        id: pageNavigation
        anchors.centerIn: parent
        nCout: 100 //总页码数
        nCurPage: 1 //当前页码
        nPageSize: 10 //默认显示页码
        //处理选中页码信号
        onSelectCurPage: {
            txtPage.text = qsTr("第") + curPage + qsTr("页");
        }
    }
}
