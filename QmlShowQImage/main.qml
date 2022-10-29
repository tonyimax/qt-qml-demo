import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: root
    visible: true
    width: 1024
    height: 768 + tabBar.height + 4
    title: qsTr("Qt基于Qml同步显示接收C++发送的QImage")
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        Page {
            id: idPageViewMulti
            width: 1024
            height: 768
            //C++对象信号连接器
            Connections {
                target: QmlImageView  //对象名
                //信号槽
                onImageViewUpdate: {
                    //###用于分隔索引  Date.now()用于更新图像
                    viewRepeater.itemAt(index).source = "image://ViewMulti/" + index + "###" + Date.now();
                }
            }
            Grid {
                rows: 3
                columns: 3
                anchors.fill: parent
                Repeater {
                    id: viewRepeater
                    model: 9

                    Image {
                        cache: false
                        mipmap: true
                        width: idPageViewMulti.width / 3
                        height: idPageViewMulti.height / 3

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            font.bold: true
                            font.pointSize: 30
                            color: "red"
                            text: index
                        }

                        Rectangle {
                            anchors.fill: parent
                            border.width: 2
                            border.color: "yellow"
                            color: "transparent"
                        }
                    }
                }
            }
        }

        Page {
            id: idPageSourceMulti
            width: 1024
            height: 768
            //C++对象信号连接器
            Connections {
                target: QmlImageView  //对象名
                onImageSourceUpdate: {
                    //###用于分隔索引  Date.now()用于更新图像
                    sourceRepeater.itemAt(index).source = "image://ViewSourceMulti/" + index + "###" + Date.now();
                }
            }
            Grid {
                rows: 2
                columns: 2
                anchors.fill: parent
                Repeater {
                    id: sourceRepeater
                    model: 4
                    Image {
                        mipmap: true
                        width: idPageSourceMulti.width / 2
                        height: idPageSourceMulti.height / 2
                        fillMode: Image.PreserveAspectFit

                        property bool running: true

                        Image {
                            width: 80
                            height: 80
                            anchors.centerIn: parent
                            opacity: 0.7
                            mipmap: true
                            source: parent.running ? "" : "qrc:/play.png"
                        }

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            anchors.top: parent.top
                            anchors.topMargin: 12
                            font.bold: true
                            font.pointSize: 30
                            color: "red"
                            text: index
                        }

                        Rectangle {
                            anchors.fill: parent
                            border.width: 2
                            border.color: "#89f2f5"
                            color: "transparent"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (parent.running) {
                                    QmlImageView.pauseImageSource(index);
                                    parent.running = false;
                                } else {
                                    QmlImageView.resumeImageSource(index);
                                    parent.running = true;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            font.pointSize: 12
            text: qsTr("同时更新多画面")
            onClicked: QmlImageView.stopImageSource();
        }

        TabButton {
            font.pointSize: 12
            text: qsTr("同时从多图像源接收画面")
            onClicked: {
                QmlImageView.startImageSource();
                for (let i = 0; i < 4; i++)
                    sourceRepeater.itemAt(i).running = true;
            }
        }
    }
}
