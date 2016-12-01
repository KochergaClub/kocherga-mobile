import QtQuick 2.7
import QtQuick.Controls 2.0
import './components'
import './views'

ApplicationWindow {
    id: window

    width: 300
    height: 500
    color: '#000'
    visible: true
    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint

    signal backButtonPressed(var event)

    FocusScope {
        focus: true
        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                window.backButtonPressed(event);
            }
        }
        Loader {
            active: true
            id: loader
            width: window.width
            height: window.height
            source: './MainView.qml'
        }
    }
}
