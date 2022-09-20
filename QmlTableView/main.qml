import QtQuick 2.8
import QtQuick.Controls 2.1

ApplicationWindow {
    id: frmWindow
    title: qsTr("基于QT的QML表格演示")
    width: 400
    height: 300
    visible: true
    onClosing: {qmlTableView.enabled = false;}

    QmlTableView{
        id: qmlTableView
        height: frmWindow.height - 40
        width: parent.width
        tableView.itemDelegate:Rectangle {
            TextField{
                id: textField
                height: 25
                text: styleData.value
                selectByMouse: true
                onEditingFinished: {
                    //调用C++原生模块方法
                    CppDefindModelObject.Set(styleData.row, styleData.column, textField.text);
                }
                visible: (styleData.column !== 0)
            }
            Image{
                id: image
                height: 25
                width: 25
                source: "qrc:/wifi.png"
                visible: (styleData.column === 0)
            }
        }
        tableView.rowDelegate: Rectangle {
            height: 25
        }
    }

    Row{
        anchors.bottom: parent.bottom
        height: 40
        width: parent.width
        Button{
            text: qsTr("添加")
            onClicked: {
                //调用C++原生模块方法
                CppDefindModelObject.Add("111",555,886.089);//调用原生对象方法
            }
        }
        Button{
            text: qsTr("删除")
            onClicked: {
                //调用C++原生模块方法
                CppDefindModelObject.Del();//调用原生对象方法
            }
        }
        Button{
            text: qsTr("刷新")
            onClicked: {
                //调用C++原生模块方法
                CppDefindModelObject.Refresh();//调用原生对象方法
            }
        }
    }
}
