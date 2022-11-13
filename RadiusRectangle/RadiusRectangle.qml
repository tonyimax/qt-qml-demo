import QtQuick 2.12
import QtQuick.Shapes 1.12
//自定义矩形组件
Shape {
    id: idShapeControl
    property var cornersRadius
    property color color
    property color borderColor:"transparent"
    property int borderWidth: 1
    layer.enabled: true
    layer.samples: 4
    layer.smooth: true
    ShapePath {
        startX: 0
        startY: cornersRadius[0]
        fillColor: color
        strokeColor: borderColor
        strokeWidth: borderWidth
        PathQuad { x: cornersRadius[0]; y: 0; controlX: 0; controlY: 0 }
        PathLine { x: idShapeControl.width - cornersRadius[1]; y: 0 }
        PathQuad { x: idShapeControl.width; y: cornersRadius[1]; controlX: idShapeControl.width; controlY: 0 }
        PathLine { x: idShapeControl.width; y: idShapeControl.height - cornersRadius[2] }
        PathQuad { x: idShapeControl.width - cornersRadius[2]; y: idShapeControl.height; controlX: idShapeControl.width; controlY: idShapeControl.height }
        PathLine { x: cornersRadius[3]; y: idShapeControl.height }
        PathQuad { x: 0; y: idShapeControl.height - cornersRadius[3]; controlX: 0; controlY: idShapeControl.height }
        PathLine { x: 0; y: cornersRadius[0] }
    }
}
