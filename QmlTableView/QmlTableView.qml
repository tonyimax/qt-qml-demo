import QtQuick 2.8
import QtQuick.Controls 1.4

TableView {
    property alias tableView: tableView

    id: tableView
    TableViewColumn {title: "表情"; role: "DisplayRole1"; width: 120}
    TableViewColumn {title: "数值1"; role: "DisplayRole2"; width: 120}
    TableViewColumn {title: "数值2"; role: "DisplayRole3"; width: 120}
    model: CppDefindModelObject //使用C++注册到根据上下文件的原生对象
    alternatingRowColors: false
    backgroundVisible: false
}
