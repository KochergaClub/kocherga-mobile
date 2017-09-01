import QtQuick 2.7
import QtQuick.Controls 2.0
import QtWebView 1.1
import '../components'
import ".."

View {
    id: view
    property ListModel entries: ListModel {}
    property var raw
    property int count: 10
    property int orgId
    property var fields: ['description_short', 'description_html']
    property string url: 'https://api.timepad.ru/v1/events.json?limit=' + count +
                         '&sort=+starts_at&fields=' + fields.join(',') + '&organization_ids[]=' + orgId
    property var monthsOf: [
      'Января', 'Февраля', 'Марта', 'Апреля', 'Мая', 'Июня',
      'Июля', 'Августа', 'Сентября', 'Октября', 'Ноября', 'Декабря'
    ]
    property var weekdays: [
      'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'
    ]
    Timer {
        id: timer
        running: true
        repeat: true
        interval: 15 * 60 * 1000
        triggeredOnStart: true
        onTriggered: {
            api.request(view.url, function(result) {
              if (!result) {
                failTimer.restart();
                return;
              }
              entries.clear();
              for (var i in result.values) {
                var el = result.values[i]
                el.start = new Date(el.starts_at)
                el.startTime = el.starts_at.replace(/.*T/, '').replace(/(:00)?[-+Z].*/, '')
                el.poster = el.poster_image.uploadcare_url ? 'http:' + el.poster_image.uploadcare_url : ''
                entries.append(el);
              }
              raw = result.values
            });
        }
    }
    Timer {
        id: failTimer
        running: false
        repeat: false
        interval: 1000
        onTriggered: timer.restart()
    }
    background: Rectangle {
      color: '#fff'
    }

    ListView {
        clip: true
        model: entries
        anchors.fill: parent
        cacheBuffer: 2000 // preserve everything, we can handle it
        displayMarginBeginning: cacheBuffer
        displayMarginEnd: cacheBuffer // load everything, there are ~5 entries
        ScrollBar.vertical: ScrollBar {}
        delegate: Column {
            width: parent.width
            Image {
                width: parent.width
                height: Math.round(width * 0.5)
                source: model.poster
                fillMode: Image.PreserveAspectCrop
                antialiasing: true
                autoTransform: true

                Rectangle {
                    color: '#000'
                    anchors.fill: parent
                    opacity: 0.3
                }
                Text {
                    text: name
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: main.pt(50)
                    font.pixelSize: main.pt(60)
                    wrapMode: Text.Wrap
                    font.bold: true
                    style: Text.Raised; styleColor: "#000"
                }
                Text {
                    text: start.getDate() + ' ' + monthsOf[start.getMonth()] + ', ' + startTime
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: main.pt(50)
                    font.pixelSize: main.pt(50)
                    font.bold: true
                    style: Text.Raised; styleColor: "#000"
                }
                Text {
                    text: weekdays[(model.start.getDay() + 6 ) % 7]
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: main.pt(50)
                    font.pixelSize: main.pt(50)
                    font.bold: true
                    style: Text.Raised; styleColor: "#000"
                }
                MouseArea {
                  enabled: false // TODO
                  anchors.fill: parent
                  onClicked: {
                    view.selected = view.raw[index]
                    main.switchTo(inner)
                  }
                }
            }
            Item {
              width: parent.width
              height: descr.implicitHeight + 2 * main.pt(50)
              Text {
                  id: descr
                  color: '#000'
                  text: description_short
                  anchors.fill: parent
                  anchors.margins: main.pt(50)
                  font.pixelSize: main.pt(50)
                  wrapMode: Text.Wrap
              }
              visible: false
            }
        }
    }
    property var selected
    Component {
      id: inner
      WebView {
        Component.onCompleted: loadHtml(view.selected.description_html)
      }
    }
}
