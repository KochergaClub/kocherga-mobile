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

    Camera {
        id: camera
        cameraState: view.active ? Camera.ActiveState : Camera.UnloadedState;
    }
    VideoOutput {
        id: video
        source: camera
        anchors.horizontalCenter: parent.horizontalCenter
        y: pt(100)
        width: Math.min(pt(1200), parent.width)
        height: width
        fillMode: VideoOutput.PreserveAspectCrop
        autoOrientation: true
    }
    MouseArea {
        // mockup
        anchors.fill: video
        onClicked: view.found = true
    }
    Text {
        anchors.top: video.bottom
        anchors.topMargin: pt(200)
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
        implicitHeight: pt(140)
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
