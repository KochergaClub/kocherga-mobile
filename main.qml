import QtQuick 2.7
import QtQuick.Controls 2.0
import './components'
import './views'

ApplicationWindow {
    id: main

    width: 300
    height: 500
    color: '#000'

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

    header: Header {}

    Drawer {
        id: drawer
        LeftMenu {
            anchors.fill: parent
        }
    }

    StackView {
        id: stack
        anchors.fill: parent
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
