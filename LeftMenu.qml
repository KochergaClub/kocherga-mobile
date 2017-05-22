import QtQuick 2.7

Item {
    anchors.fill: parent
    Column {
        spacing: 0
        anchors.fill: parent
        Rectangle {
            height: main.anchors.topMargin
            width: parent.width
            color: '#000'
        }
        LeftMenuItem {
            text: 'Прямо сейчас'
            onClicked: switchTo(now)
        }
        Repeater {
            model: api.pages
            delegate: LeftMenuItem {
                text: model.name
                onClicked: {
                    if (model.external) {
                        Qt.openUrlExternally(model.url)
                        drawer.close();
                    } else {
                        switchTo(api.webviews[index])
                    }
                }
            }
        }
    }
    MouseArea {
        visible: api.loggedIn
        anchors.bottom: parent.bottom
        height: pt(160)
        width: parent.width
        onClicked: {
            api.loggedIn = false;
            switchTo(coins)
        }
        Text {
            id: text
            text: 'Выйти'
            font.pixelSize: pt(60)
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: pt(50)
        }
        Rectangle {
            anchors.top: parent.top
            width: parent.width
            color: '#000'
            height: pt(5, 1)
        }
    }
}

