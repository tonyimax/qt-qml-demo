import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt基于Qml向左边滑动删除列表项")
    //列表数据源
    ListModel {
        id: listModel

        ListElement {
            text: qsTr("1.向左边滑动出现删除按钮")
        }
        ListElement {
            text: qsTr("2.向左边滑动出现删除按钮")
        }
        ListElement {
            text: qsTr("3.向左边滑动出现删除按钮")
        }
        ListElement {
            text: qsTr("4.向左边滑动出现删除按钮")
        }
        ListElement {
            text: qsTr("5.向左边滑动出现删除按钮")
        }
    }
    //列表控件
    ListView{
        id: listview
        width: parent.width
        height: parent.height
        anchors.fill: parent
        model: listModel
        delegate: listDelegate //列表项组件ID
    }

    //列表项组件
    Component{
        id: listDelegate
        Rectangle{
            id: listItem
            width: parent.width
            height: 60
            Text {
                id: text
                font.family: "microsoft yahei"
                font.pointSize: 18
                height: parent.height
                width: parent.width - delBtn.width
                text: model.text
                color: "green"
                verticalAlignment: Text.AlignVCenter
                anchors.left: parent.left
                anchors.leftMargin: 30
                MouseArea{
                    property point clickPos: "0,0"
                    anchors.fill: parent
                    onPressed: {
                        clickPos  = Qt.point(mouse.x,mouse.y);//取鼠标坐标
                    }
                    onReleased: {
                        var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)//释放鼠标后坐标
                        if ((delta.x < 0) && (aBtnShow.running === false) && (delBtn.width === 0)){
                            aBtnShow.start();
                        }else if (aBtnHide.running === false && (delBtn.width > 0)){
                            aBtnHide.start();
                        }
                    }
                }
            }
            Rectangle{
                color: "#AAAAAA"
                height: 1
                width: parent.width
                anchors.bottom: parent.bottom
            }
            Rectangle{
                id: delBtn
                height: parent.height
                color: "#EE4040"
                anchors.right: parent.right
                Text {
                    font.family: "microsoft yahei"
                    font.pointSize: 18
                    anchors.centerIn: parent
                    text: qsTr("删除")
                    color: "#ffffff"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        listview.model.remove(index);
                    }
                }
            }
            PropertyAnimation{
                id: aBtnShow
                target: delBtn
                property: "width"
                duration: 100
                from: 0
                to: 60
            }
            PropertyAnimation{
                id: aBtnHide
                target: delBtn
                property: "width"
                duration: 100
                from: 60
                to: 0
            }
        }
    }
}
