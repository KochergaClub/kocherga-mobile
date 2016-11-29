import QtQuick 2.0
import QtQuick.Controls 2.0

TextField {
    width: pt(300)
    height: pt(120)
    font.pixelSize: Math.round(height * 0.6)

    property int radius: pt(8)
    property color backgroundColor: enabled ? "#fff" : "#353637"
    property int borderWidth: activeFocus ? 1 : 0
    property color borderColor: activeFocus ? "#FF5D18" : (enabled ? "#bdbebf" : "transparent")

    Component.onCompleted: {
        background.radius = Qt.binding(function() { return radius });
        background.color = Qt.binding(function() { return backgroundColor });
        background.border.width = Qt.binding(function() { return borderWidth });
        background.border.color = Qt.binding(function() { return borderColor });
    }
}
