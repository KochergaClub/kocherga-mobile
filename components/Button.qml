import QtQuick 2.0
import QtQuick.Controls 2.0

Button {
    font.pixelSize: height * 0.4
    width: pt(300)
    height: pt(150)

    property color color: '#fff'
    property color pressedColorText: '#000'
    property color pressedColor: highlighted ? '#fff' : color
    property bool solid: highlighted || checkable && checked || pressed
    property color actualColor: pressed ? pressedColor : color
    property color bgColor: solid ? actualColor : 'transparent'
    property color textColor: solid ? pressedColorText : actualColor
    property int borderWidth: 2
    property int radius: implicitHeight / 2
    property bool bold: false

    Component.onCompleted: {
        background.color = Qt.binding(function() { return bgColor });
        background.radius = Qt.binding(function() { return radius });
        background.border.color = Qt.binding(function() { return actualColor });
        background.border.width = Qt.binding(function() { return borderWidth });
        contentItem.color = Qt.binding(function() { return textColor });
        contentItem.font.bold = Qt.binding(function() { return bold });
    }
}
