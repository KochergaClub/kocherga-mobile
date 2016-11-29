import QtQuick 2.0
import QtQuick.Controls 2.0

Drawer {
    width: 0.8 * parent.width
    height: parent.height + header.height// + footer.height
    property color color: '#fff'
    property bool enabled: true
    dragMargin: enabled ? Qt.styleHints.startDragDistance : 0

    Behavior on position {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }
    Component.onCompleted: {
        background.color = Qt.binding(function() { return color });
    }
}
