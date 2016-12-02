import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebView 1.1
import './components'
import './views'

Item {
    id: main

    anchors.fill: parent
    anchors.topMargin: (window.platform === 'ios' || window.platform === 'osx') ? 20 : 0

    property string platform: typeof AppPlatform !== 'undefined' ? AppPlatform : ''
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
    Help {
        id: help
        visible: false
    }
    About {
        id: about
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

    WebView {
        id: timepad
        url: api.timepad
        visible: false
    }
}
