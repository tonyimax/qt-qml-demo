import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1

ApplicationWindow {
    visible: true
    width: 600
    height: 200
    title: qsTr("Qt6基于Qml的文件对话框演示")
    Row{
        anchors.centerIn: parent
        spacing: 30
        Button{
            text: qsTr("Open")
            height: 48
            width: 120
            MouseArea{
                anchors.fill: parent
                onClicked: {
                   idFileOpenOne.open();
                }
            }
        }
        Button{
            text: qsTr("Open More ...")
            height: 48
            width: 120
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    idFileOpenMore.open();
                }
            }
        }
        Button{
            text: qsTr("Save")
            height: 48
            width: 120
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    idFileSave.open();
                }
            }
        }
    }

    FileDialog {
        id: idFileOpenOne
        fileMode: FileDialog.OpenFile
        nameFilters: ["Pictures (*.png *.jpg *.gif *.bmp)", "All (*.*)"]
        options :FileDialog.ReadOnly
    }

    FileDialog {
        id: idFileOpenMore
        fileMode: FileDialog.OpenFiles
        nameFilters: ["Pictures (*.png *.jpg *.gif *.bmp)", "All (*.*)"]
        options :FileDialog.ReadOnly
    }
    FileDialog {
        id: idFileSave
        nameFilters: ["Pictures (*.png *.jpg *.gif *.bmp)", "All (*.*)"]
        fileMode: FileDialog.SaveFile
    }
}
