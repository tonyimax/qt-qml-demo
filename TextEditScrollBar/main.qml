import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt基于Qml实现带滚动条的TextEdit")
    Rectangle {
          id: frame
          clip: true
          width: parent.width
          height: parent.height
          border.color: "black"
          color: "blue"
          anchors.centerIn: parent
          anchors.top: parent.bottom
          anchors.left: parent.left
          focus: true
          Keys.onUpPressed: vbar.decrease();//键盘上箭头键操作滚动条
          Keys.onDownPressed: vbar.increase();//键盘下箭头键操作滚动条
          //文本编辑器
          TextEdit {
              id: textEdit
              text: "ABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKL" +
                    "ABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKLABCDEFGHIJKL"
              font.pointSize: 14
              color:"white"
              height: contentHeight
              width: frame.width - vbar.width
              y: -vbar.position * textEdit.height
              wrapMode: TextEdit.Wrap
              selectByKeyboard: true //支持键盘选择
              selectByMouse: true //支持鼠标选择
              //鼠标区域
              MouseArea{
                  anchors.fill: parent
                  //鼠标中键滚动信号
                  onWheel: {
                      if (wheel.angleDelta.y > 0) {
                          vbar.decrease();
                      }
                      else {
                          vbar.increase();
                      }
                  }
                  onClicked: {
                      textEdit.forceActiveFocus();//强制获得焦点
                  }
              }
          }
          //滚动条
          ScrollBar {
              id: vbar
              hoverEnabled: true
              active: hovered || pressed //鼠标在文本编辑框内或者按下鼠标显示滚动条
              orientation: Qt.Vertical //垂直方向
              size: frame.height / textEdit.height
              width: 10
              //滚动条位置-右边
              anchors.top: parent.top
              anchors.right: parent.right
              anchors.bottom: parent.bottom
              //滚动条背景
              background: Rectangle{
                  color: "green"
              }
          }
      }
}
