import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Qt基于Qml图像通过Shader倒影实现")
    color: "#AAAAAA"

    Image {
        id: img
        width: 256
        height: 256
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/qt.png"
        //图像Shader特效
        ShaderEffect {
            height: parent.height
            width: parent.width
            anchors.top: parent.bottom
            anchors.left: parent.left
            property variant source: img
            property size sourceSize: Qt.size(0.5 / img.width, 0.5 / img.height)
            //通过OpenGL的Shader实现
            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform lowp sampler2D source;
                uniform lowp vec2 sourceSize;
                uniform lowp float qt_Opacity;
                void main() {
                    lowp vec2 tc = qt_TexCoord0 * vec2(1, -1) + vec2(0, 1);
                    lowp vec4 col = 0.25 * (texture2D(source, tc + sourceSize)
                                            + texture2D(source, tc- sourceSize)
                                            + texture2D(source, tc + sourceSize * vec2(1, -1))
                                            + texture2D(source, tc + sourceSize * vec2(-1, 1))
                                           );
                    gl_FragColor = col * qt_Opacity * (1.0 - qt_TexCoord0.y) * 0.5;
                }"
        }
    }
}
