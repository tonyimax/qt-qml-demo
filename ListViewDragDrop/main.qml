import QtQuick 2.12
import QtQuick.Controls 2.12
ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml列表项拖放操作示例")
    ListModel {
        id: listModel

        ListElement {
            text: qsTr("1.列表项拖放操作示例A")
        }
        ListElement {
            text: qsTr("2.列表项拖放操作示例B")
        }
        ListElement {
            text: qsTr("3.列表项拖放操作示例C")
        }
        ListElement {
            text: qsTr("4.列表项拖放操作示例D")
        }
        ListElement {
            text: qsTr("5.列表项拖放操作示例E")
        }
    }

    ListView{
        id: listview
        width: parent.width
        height: parent.height
        anchors.fill: parent
        model: listModel
        delegate: listDelegate
        interactive: false
    }

    Component{
        id: listDelegate
        Rectangle{
            property int fromIndex: 0
            property int toIndex: 0

            id: listItem
            width: parent.width
            height: 30

            Text {
                id: label
                font.family: "microsoft yahei"
                font.pointSize: 12
                height: parent.height
                width: parent.width
                text: model.text
                color: "#148014"
                verticalAlignment: Text.AlignVCenter
            }
            Rectangle{
                color: "#AAAAAA"
                height: 1
                width: parent.width
                anchors.bottom: parent.bottom
            }
            MouseArea {
                id: mousearea
                anchors.fill: parent
                onPressed: {
                    listview.currentIndex = index;
                    listItem.fromIndex = index;
                    label.color = "white";
                    listItem.color="#FF00FF";
                }
                onReleased: {
                    label.color = "#148014"
                    listItem.color="#FFFFFF";
                    console.debug("fromIndex: ", listItem.fromIndex, "toIndex: ", listItem.toIndex);
                }
                onMouseYChanged: {
                    var lastIndex = listview.indexAt(mousearea.mouseX + listItem.x,
                                                     mousearea.mouseY + listItem.y);
                    if ((lastIndex < 0) || (lastIndex > listModel.rowCount()))
                        return;
                    if (index !== lastIndex){
                        listModel.move(index, lastIndex, 1);
                    }
                    listItem.toIndex = lastIndex;
                }
            }
        }
    }
}
