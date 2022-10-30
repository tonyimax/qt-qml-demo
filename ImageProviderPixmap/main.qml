import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("图像提供者之Pixmap")
    Image {
        anchors.centerIn: parent
        //imageProviderPixmap为自下定义的图像提供者
        source: "image://imageProviderPixmap/qt.png"
    }
}
