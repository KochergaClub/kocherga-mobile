import QtQuick 2.7
import '../components'

View {
    id: view
    property int num: api.people
    property int numv: (num % 100 >= 12 && num % 100 <= 14) ? 0 :
                       (num % 10 >= 2 && num % 10 <= 4) ? 1 :
                       0

    Timer {
        interval: 10000
        running: view.visible
        repeat: true
        triggeredOnStart: true
        onTriggered: api.refreshPeople()
    }

    Column {
        id: counter
        anchors.centerIn: parent
        Text {
            text: 'Сейчас в антикафе'
            font.bold: true
            color: '#ccc'
            font.pixelSize: pt(100)
            horizontalAlignment: Text.AlignHCenter
            width: view.width
        }
        Text {
            text: num
            font.pixelSize: pt(400)
            horizontalAlignment: Text.AlignHCenter
            width: view.width
        }
        Text {
            text: ['человек', 'человека'][numv]
            font.bold: true
            color: '#ccc'
            font.pixelSize: pt(100)
            horizontalAlignment: Text.AlignHCenter
            width: view.width
        }
        Item {
            width: 1
            height: pt(140)
        }
        Text {
            text: '(не считая администратора)'
            horizontalAlignment: Text.AlignHCenter
            width: view.width
        }
    }
}
