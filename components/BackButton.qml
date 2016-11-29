import QtQuick 2.0

MouseArea {
    id: mousearea
    width: pt(30) + text.implicitWidth
    onPressed: {
        stack.pop();
    }
    Row {
        id: text
        anchors.centerIn: parent
        Text {
            text: '< '
            color: '#fff'
            font.pixelSize: pt(80)
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            text: 'Назад'
            color: '#fff'
            font.pixelSize: pt(50)
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
