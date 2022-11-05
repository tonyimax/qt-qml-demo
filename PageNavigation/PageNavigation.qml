import QtQuick 2.12
import QtQuick.Controls 2.12

Row{
    id: pageNavigation
    property int nCout: 1
    property int nCurPage: 1
    property int nPageSize: 1
    //选择了页码信号
    signal selectCurPage(int curPage);
    //上一页
    Rectangle{
        id: prevPage
        height: 30
        width: 100
        color: "#EEEEEE"
        border.color: "#AAAAAA"
        border.width: 1
        Row{
            anchors.centerIn: parent
            Image{
                height: 16
                width: 16
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/arrow.png"
                rotation: -180
            }
            Text {
                font.family: "microsoft yahei"
                font.pixelSize: 22
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("上一页")
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (pageNavigation.nCurPage > 1) pageNavigation.nCurPage--;
            }
        }
    }
    //通过重复生成器生成页码
    Repeater{
        id: repeater
        model: pageNavigation.nPageSize
        delegate: Rectangle{
            //当前选中页码
            property int nCurIndex: (pageNavigation.nCurPage-1)*pageNavigation.nPageSize + index + 1
            //是否有页码
            property bool hasPage: nCurIndex <= pageNavigation.nCout

            height: 30
            width: 60
            color: hasPage ? "#EEEEEE" : "transparent"
            border.color: "#AAAAAA"
            border.width: hasPage ? 1 : 0
            Text {
                id:idPageText
                font.family: "microsoft yahei"
                font.pixelSize: 22
                anchors.centerIn: parent
                text: nCurIndex
                visible: hasPage ? true : false
                color: "#148014"
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: hasPage
                onEntered: {
                    parent.color = "#148014"
                    idPageText.color="#FFFFFF"
                }
                onExited: {
                    parent.color = "#EEEEEE"
                    idPageText.color="#148014"
                }
                onPressed: {
                    idPageText.color="red"
                    selectCurPage(nCurIndex);
                }
            }
        }
    }
    //下一页
    Rectangle{
        id: nextPage
        height: 30
        width: 100
        color: "#EEEEEE"
        border.color: "#AAAAAA"
        border.width: 1
        Row{
            anchors.centerIn: parent
            Text {
                font.family: "microsoft yahei"
                font.pixelSize: 22
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("下一页")
            }
            Image{
                height: 16
                width: 16
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/arrow.png"
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if (pageNavigation.nCurPage*pageNavigation.nPageSize <= pageNavigation.nCout) pageNavigation.nCurPage++;
            }
        }
    }
}
