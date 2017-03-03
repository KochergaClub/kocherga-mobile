import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebView 1.1
import './components'
import './views'

Item {
    id: main

    anchors.fill: parent
    anchors.topMargin: (Qt.platform.os === 'ios' || Qt.platform.os === 'osx') ? 20 : 0

    property int baseWidth: 1080
    property int baseHeight: 1920
    property real px: Math.min(width, height * baseWidth / baseHeight) / baseWidth

    function pt(size, min) {
        return Math.max(Math.round(px * size), min || 0);
    }

    function switchTo(arg) {
        if (stack.currentItem !== arg) {
            stack.pop(null);
            stack.replace(arg);
        }
        drawer.close()
    }

    Connections {
        target: window
        onBackButtonPressed: {
            if (stack.depth > 1) {
                stack.pop();
                event.accepted = true;
            }
        }
    }

    Api {
        id: api
    }

    Drawer {
        id: drawer
        LeftMenu {
            anchors.fill: parent
        }
    }

    Header {
        id: header
        transform: Translate {
            x: drawer.position * drawer.width
        }
    }

    StackView {
        id: stack
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        x: drawer.position * drawer.width
        width: parent.width
        initialItem: coins
    }

    Coins {
        id: coins
        visible: false
    }
    Now {
        id: now
        visible: false
    }

    Component {
        id: coinsGive
        CoinsGive {}
    }
    Component {
        id: coinsReceive
        CoinsReceive {}
    }

    Repeater {
        model: api.pages
        delegate: WebView {
            // TODO: remove external urls?
            // If we need those, we probably don't want spawning empty
            // WebViews for those
            url: model.external ? '' : model.url
            visible: false
            Component.onCompleted: api.webviews[index] = this
            // TODO: reload on network errors
        }
    }
}
