import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtMultimedia 5.7
import '../components'

View {
    id: view
    property bool active: true
    property bool found: false
    property real value: 1

    QrScanner {
        id: scanner
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: parent.height - pt(560)
        cameraState: view.active ? Camera.ActiveState : Camera.UnloadedState;
        onTagFound: {
            api.codeInfo(tag, function(info) {
                if (info.type === 'coins') {
                    view.value = info.value;
                    view.found = true;
                }
            })
        }
    }

    Text {
        anchors.top: scanner.bottom
        anchors.topMargin: pt(100)
        anchors.horizontalCenter: parent.horizontalCenter
        text: view.value + ' юдк.'
        font.pixelSize: pt(100)
        visible: view.found
    }
    Item {
        width: view.width * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: pt(100)
        height: pt(140)
        Button {
            id: abortButton
            text: 'Отмена'
            onClicked: view.found = false
            width: view.width * 0.4
            anchors.left: parent.left
            height: parent.height
        }
        Button {
            id: okButton
            text: 'Принять'
            onClicked: {
                // mockup
                api.coins += view.value;
                stack.pop();
            }
            width: view.width * 0.4
            anchors.right: parent.right
            height: parent.height
        }
        visible: view.found
    }
    Button {
        text: 'Отмена'
        onClicked: stack.pop()
        width: view.width * 0.4
        height: pt(140)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: pt(100)
        visible: !view.found
    }
}
