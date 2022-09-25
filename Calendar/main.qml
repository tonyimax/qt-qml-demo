import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 520
    height: 520
    title: qsTr("QT日历控件演示")

    function dayValid(date){
        var myArray = new Array();
        //指定日期不可点击
        myArray[0]="5";
        myArray[1]="21";
        myArray[2]="30";
        for(var i = 0; i < myArray.length;i++)
        {
            if (myArray[i] === date)
            {
                return(false);//false为不可点击
            }
        }
        return(true);
    }

    Calendar {
        anchors.centerIn: parent
        width:500
        height:500
        style: CalendarStyle {
            gridVisible: false //不显示表格线
            dayDelegate: Rectangle {
                property bool dayIsValid: dayValid(styleData.date.getDate().toString())
                //日期控件每一天格子颜色
                gradient: Gradient {
                    GradientStop {
                        position: 0.00
                        color: styleData.selected && dayIsValid ? "#148014" :
                                    (styleData.visibleMonth && styleData.valid ?
                                          (dayIsValid ? "red" : "grey") : "#FF00FF");
                    }
                }

                //日期控件每一天文字
                Label {
                    text: styleData.date.getDate()
                    color: "#ffffff"
                    font.pixelSize: 20
                    anchors.centerIn: parent
                }
                //下线条
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#EEEEEE"
                    anchors.bottom: parent.bottom
                }
                //右线条
                Rectangle {
                    width: 1
                    height: parent.height
                    color: "#EEEEEE"
                    anchors.right: parent.right
                }
            }
        }
    }
}
