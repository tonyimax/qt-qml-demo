import QtQml 2.12
import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: root
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml上下拉刷新列表")

    property int nCurUp: 0
    property int nCurDown: 18
    property int nPullHeight: 64

    //下拉刷新
    function funDownRefresh(){
        console.debug(qsTr("下拉刷新"))
        listView.y = -nPullHeight;
        busyDownRefresh.running = false;
        timerDownRefresh.start();
    }
    //下拉等待指示器
    BusyIndicator {
        id: busyDownRefresh
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: 48
        implicitHeight: 48
        opacity: running ? 0.0 : 1.0
        contentItem: MyBusyIndicator{}
    }
    //下拉定时器
    Timer{
        id: timerDownRefresh
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            busyDownRefresh.running = true;

            //上面增加数据
            listModel.append({"name": nCurDown.toString(), "number": nCurDown.toString()});
            nCurDown++;
            listModel.append({"name": nCurDown.toString(), "number": nCurDown.toString()});
            nCurDown++;
            listModel.append({"name": nCurDown.toString(), "number": nCurDown.toString()});
            nCurDown++;

            aniDownRefresh.start();
        }
    }
    //下拉刷新动画
    NumberAnimation {
        id: aniDownRefresh
        target: listView
        property: "y"
        duration: 200
        from: -nPullHeight
        to: 0
        onStopped: {
            listView.contentY = listView.contentHeight - listView.height;
        }
    }

    //上拉刷新
    function funUpRefresh(){
        console.debug(qsTr("上拉刷新"))
        listView.y = nPullHeight;
        busyUpRefresh.running = false;
        timerUpRefresh.start();
    }

    //上拉等待指示器
    BusyIndicator {
        id: busyUpRefresh
        anchors.top: parent.top
        anchors.topMargin: 6
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: 48
        implicitHeight: 48
        opacity: running ? 0.0 : 1.0
        contentItem: MyBusyIndicator{}
    }
    //上拉定时器
    Timer{
        id: timerUpRefresh
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            busyUpRefresh.running = true;//显示等待指示器
            //上面增加数据
            listModel.insert(0, {"name": nCurUp.toString(),
                                 "number": nCurUp.toString()});
            nCurUp--;
            listModel.insert(0, {"name": nCurUp.toString(),
                                 "number": nCurUp.toString()});
            nCurUp--;
            listModel.insert(0, {"name": nCurUp.toString(),
                                 "number": nCurUp.toString()});
            nCurUp--;
            aniUpRefresh.start();//播放动画
        }
    }
    //上拉刷新动画
    NumberAnimation {
        id: aniUpRefresh
        target: listView
        property: "y"
        duration: 200
        from: nPullHeight
        to: 0
        onStopped: {
            listView.y = 0;
        }
    }
    //列表控件
    ListView {
        id: listView
        width: parent.width
        height: parent.height
        model: listModel
        delegate: Rectangle{
            height: 24
            width: parent.width
            border.color: "#AAAAAA"
            border.width: 1
            //显示文本
            Text {
                font.family: "microsoft yahei"
                font.pixelSize: 15
                anchors.centerIn: parent
                text: name + ": " + number
            }
        }
        states: [
            State {
                id: downRefresh
                name: "downRefresh"; when: (listView.contentHeight > 0) && (listView.contentY > (listView.contentHeight - root.height + nPullHeight))
                StateChangeScript {
                    name: "funDownRefresh"
                    script: funDownRefresh()
                }
            },
            State {
                id: upRefresh
                name: "upRefresh"; when: (listView.contentY < -nPullHeight)
                StateChangeScript {
                    name: "funUpRefresh"
                    script: funUpRefresh()
                }
            }
        ]
    }

    //数据源
    ListModel {
        id: listModel
        ListElement {
            name: "A"
            number: "01"
        }
        ListElement {
            name: "B"
            number: "02"
        }
        ListElement {
            name: "C"
            number: "03"
        }
        ListElement {
            name: "D"
            number: "04"
        }
        ListElement {
            name: "E"
            number: "05"
        }
        ListElement {
            name: "F"
            number: "06"
        }
        ListElement {
            name: "G"
            number: "07"
        }
        ListElement {
            name: "H"
            number: "08"
        }
        ListElement {
            name: "I"
            number: "09"
        }
        ListElement {
            name: "J"
            number: "10"
        }
        ListElement {
            name: "K"
            number: "11"
        }
        ListElement {
            name: "L"
            number: "12"
        }
        ListElement {
            name: "M"
            number: "13"
        }
        ListElement {
            name: "N"
            number: "14"
        }
        ListElement {
            name: "O"
            number: "15"
        }
        ListElement {
            name: "P"
            number: "16"
        }
        ListElement {
            name: "Q"
            number: "17"
        }
        ListElement {
            name: "R"
            number: "18"
        }
    }

}
