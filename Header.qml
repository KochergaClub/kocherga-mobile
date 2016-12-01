import QtQuick 2.7
import './components'

Item {
    height: pt(160)
    width: parent.width
    Item {
        height: parent.height
        width: 2 * parent.width
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
