import QtQuick 2.7
import QtQuick.Controls 2.0
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
    }

    StackView {
        id: stack
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
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
}
