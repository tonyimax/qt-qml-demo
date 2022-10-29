import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    height: gridView.cellHeight*6+4*2
    width: gridView.cellWidth*10+4*2
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint //无标题窗口

    ListModel {id: listModel} //表格数据源

    Component{
        id: baseListDelegate
        //表情项
        Item {
            id: delegateItem
            height: gridView.cellHeight
            width: gridView.cellWidth
            Rectangle{
                id: delegateItemBack
                anchors.fill: parent
                color : "#FF00FF"
                radius: 5
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        //选择的表情在表格中的索引
                        delegateItem.GridView.view.currentIndex = model.index;
                    }
                }

                Image {
                    id: image
                    anchors.centerIn: parent
                    source: face
                    width: 32
                    height: 32
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.debug(qsTr("选中表情: ") + face)
                            close() //选择表情后关闭窗口
                        }
                    }
                }
            }

            //项状态处理
            states: [
                State {
                    name: "isCurrentItem"
                    when: delegateItem.GridView.isCurrentItem //属性改变条件
                    PropertyChanges {
                        target: delegateItemBack; color : "#FF00FF"; //当前项颜色
                    }
                },
                State {
                    name: "isNotCurrentItem"
                    when: !delegateItem.GridView.isCurrentItem //属性改变条件
                    PropertyChanges {
                        target: delegateItemBack; color : "transparent"; //其它项透明
                    }
                }
            ]
        }
    }

    //表格视图
    GridView {
        id: gridView
        anchors.margins: 4
        anchors.fill: parent
        clip: true
        //表格中单元格宽高
        cellWidth: 40
        cellHeight: 40
        model: listModel //表格视图数据源
        delegate: baseListDelegate //表格中单元格组件
        boundsBehavior: Flickable.StopAtBounds
        //组件初始化完成时添加表情到数据源
        Component.onCompleted: {
            listModel.append({"face" : "emoji/Face_(0).png"})
            listModel.append({"face" : "emoji/Face_(1).png"})
            listModel.append({"face" : "emoji/Face_(2).png"})
            listModel.append({"face" : "emoji/Face_(3).png"})
            listModel.append({"face" : "emoji/Face_(4).png"})
            listModel.append({"face" : "emoji/Face_(5).png"})
            listModel.append({"face" : "emoji/Face_(6).png"})
            listModel.append({"face" : "emoji/Face_(7).png"})
            listModel.append({"face" : "emoji/Face_(8).png"})
            listModel.append({"face" : "emoji/Face_(9).png"})
            listModel.append({"face" : "emoji/Face_(10).png"})
            listModel.append({"face" : "emoji/Face_(11).png"})
            listModel.append({"face" : "emoji/Face_(12).png"})
            listModel.append({"face" : "emoji/Face_(13).png"})
            listModel.append({"face" : "emoji/Face_(14).png"})
            listModel.append({"face" : "emoji/Face_(15).png"})
            listModel.append({"face" : "emoji/Face_(16).png"})
            listModel.append({"face" : "emoji/Face_(17).png"})
            listModel.append({"face" : "emoji/Face_(18).png"})
            listModel.append({"face" : "emoji/Face_(19).png"})
            listModel.append({"face" : "emoji/Face_(20).png"})
            listModel.append({"face" : "emoji/Face_(21).png"})
            listModel.append({"face" : "emoji/Face_(22).png"})
            listModel.append({"face" : "emoji/Face_(23).png"})
            listModel.append({"face" : "emoji/Face_(24).png"})
            listModel.append({"face" : "emoji/Face_(25).png"})
            listModel.append({"face" : "emoji/Face_(26).png"})
            listModel.append({"face" : "emoji/Face_(27).png"})
            listModel.append({"face" : "emoji/Face_(28).png"})
            listModel.append({"face" : "emoji/Face_(29).png"})
            listModel.append({"face" : "emoji/Face_(30).png"})
            listModel.append({"face" : "emoji/Face_(31).png"})
            listModel.append({"face" : "emoji/Face_(32).png"})
            listModel.append({"face" : "emoji/Face_(33).png"})
            listModel.append({"face" : "emoji/Face_(34).png"})
            listModel.append({"face" : "emoji/Face_(35).png"})
            listModel.append({"face" : "emoji/Face_(36).png"})
            listModel.append({"face" : "emoji/Face_(37).png"})
            listModel.append({"face" : "emoji/Face_(38).png"})
            listModel.append({"face" : "emoji/Face_(39).png"})
            listModel.append({"face" : "emoji/Face_(40).png"})
            listModel.append({"face" : "emoji/Face_(41).png"})
            listModel.append({"face" : "emoji/Face_(42).png"})
            listModel.append({"face" : "emoji/Face_(43).png"})
            listModel.append({"face" : "emoji/Face_(44).png"})
            listModel.append({"face" : "emoji/Face_(45).png"})
            listModel.append({"face" : "emoji/Face_(46).png"})
            listModel.append({"face" : "emoji/Face_(47).png"})
            listModel.append({"face" : "emoji/Face_(48).png"})
            listModel.append({"face" : "emoji/Face_(49).png"})
            listModel.append({"face" : "emoji/Face_(50).png"})
            listModel.append({"face" : "emoji/Face_(51).png"})
            listModel.append({"face" : "emoji/Face_(52).png"})
            listModel.append({"face" : "emoji/Face_(53).png"})
            listModel.append({"face" : "emoji/Face_(54).png"})
            listModel.append({"face" : "emoji/Face_(55).png"})
            listModel.append({"face" : "emoji/Face_(56).png"})
        }
    }
}
