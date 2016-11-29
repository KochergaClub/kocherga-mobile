import QtQuick 2.7
import '../components'

View {
    id: view
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: pt(700)
        font.pixelSize: pt(120)
        text: api.coins + ' юдк.'
    }
    Item {
        width: view.width * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: pt(100)
        height: pt(140)
        Button {
            id: giveButton
            text: 'Отдать'
            onClicked: stack.push(coinsGive)
            width: view.width * 0.4
            anchors.left: parent.left
            height: parent.height
        }
        Button {
            id: receiveButton
            text: 'Принять'
            onClicked: stack.push(coinsReceive)
            width: view.width * 0.4
            anchors.right: parent.right
            height: parent.height
        }
    }
    Login {
        visible: !api.loggedIn
    }
}
