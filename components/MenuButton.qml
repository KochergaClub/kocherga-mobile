import QtQuick 2.0

MouseArea {
    id: mousearea
    width: height
    onPressed: {
        drawer.open();
    }
    Column {
        id: button
        anchors.centerIn: parent
        width: pt(80)
        spacing: pt(20)
        Repeater {
            model: 3
            Rectangle {
                width: button.width
                height: pt(9)
                color: '#fff'
            }
        }
    }
}
