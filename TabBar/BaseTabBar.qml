import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
TabBar {
    property alias myModel: idTabbarModel
    property int lastIndex: 0
    id: idTabbar
    currentIndex: 0
    ListModel {id: idTabbarModel}
    Repeater {
        id: idRepeaterControl
        model: idTabbarModel
        TabButton {
            property alias imageSource: image.source //图像
            property alias textColor: text.color //文本
            height: idTabbar.height
            contentItem:Text{
                id: text
                text: modelText
                font.pixelSize: 24
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                color: (model.index === idTabbar.currentIndex) ? modelColorG : modelColor
            }

            background:Image{
                id: image
                width: 48
                height: 48
                anchors.horizontalCenter: parent.horizontalCenter
                source: (model.index === idTabbar.currentIndex) ? modelSrcG : modelSrc
                ColorOverlay{
                            anchors.fill: image
                            source: image
                            color: "red"
                        }

            }
            //鼠标经过事件处理
            onHoveredChanged: {
                if (model.index !== idTabbar.currentIndex){
                    hovered ? text.color = modelColorG : text.color = modelColor
                    hovered ? image.source = modelSrcG : image.source = modelSrc
                }
            }
            //点击事件处理
            onClicked: {
                idRepeaterControl.itemAt(idTabbar.lastIndex).imageSource = myModel.get(idTabbar.lastIndex).modelSrc;
                idRepeaterControl.itemAt(idTabbar.lastIndex).textColor = modelColor;
                image.source = modelSrcG;
                text.color = modelColorG;
                idTabbar.lastIndex = model.index;
            }
        }
    }
}
