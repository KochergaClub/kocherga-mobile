import QtQuick 2.7
import './components'

Item {
    property int topPadding: (main.platform === 'ios' || main.platform === 'osx') ? 20 : 0
    height: topPadding + pt(160)
    width: main.width
    Item {
        height: parent.height - topPadding
        width: 2 * parent.width
        y: topPadding
        x: stack.depth > 1 ? -main.width : 0
        Behavior on x {
            XAnimator {
                duration: 400
                easing.type: Easing.OutCubic
            }
        }
        MenuButton {
            height: parent.height
        }
        BackButton {
            x: main.width
            height: parent.height
        }
    }
}
