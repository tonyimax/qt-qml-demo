import QtQuick 2.0
import QtQuick.Controls 2.0

BusyIndicator{
     property int nSize: 100 //大小
     property string from //开始颜色
     property string to //结束颜色
     id: busyIndicator
     anchors.centerIn: parent
     implicitWidth: nSize
     implicitHeight: nSize
     contentItem: QmlBusyIndicator{
          fromColor: from //? fromColor : "#80c342"
          toColor: to //? toColor : "#006325"
     } //使用默认颜色
}
