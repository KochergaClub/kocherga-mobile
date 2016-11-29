import QtQuick 2.7

MouseArea {
    property alias text: text.text
    height: pt(160)
    width: parent.width
    Text {
        id: text
        font.pixelSize: pt(60)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: pt(50)
    }
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        color: '#000'
        height: pt(5, 1)
    }
}
