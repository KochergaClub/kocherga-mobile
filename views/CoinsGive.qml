import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import '../components'

View {
    id: view
    Item {
        visible: !result.visible
        width: view.width * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: pt(100)
        height: pt(140)
        SpinBox {
            id: spinbox
            from: 0
            value: 10
            to: api.coins * 10
            stepSize: 1

            property real realValue: value / 10

            validator: DoubleValidator {
                bottom: Math.min(spinbox.from, spinbox.to)
                top:  Math.max(spinbox.from, spinbox.to)
            }
            textFromValue: function(value) {
                return Number(value / 10).toString()
            }
            valueFromText: function(text) {
                return parseFloat(text, 10) * 10
            }
            anchors.left: parent.left
            width: view.width * 0.45
            height: parent.height
        }
        Button {
            id: button
            anchors.right: parent.right
            text: 'Создать'
            onClicked: {
                api.codeCreate({
                    type: 'coins',
                    value: spinbox.realValue,
                }, function(res) {
                    qrcode.value = res.code;
                    result.value = res.value;
                    result.visible = true;
                });
            }
            width: view.width * 0.4
            height: parent.height
        }
    }

    Item {
        id: result
        property real value
        visible: false
        height: pt(1400)
        width: parent.width
        QrCode {
            id: qrcode
            type: 3
            level: 2
            height: pt(900)
            anchors.centerIn: parent
            width: height
        }
        Connections {
            target: api
            onCodeDestroyed: {
                if (code === qrcode.value) {
                    stack.pop();
                }
            }
        }

        MouseArea {
            // mockup
            anchors.fill: qrcode
            onClicked: api.codeConsume(qrcode.value)
        }
        Text {
            anchors.top: qrcode.bottom
            anchors.topMargin: pt(100)
            anchors.horizontalCenter: parent.horizontalCenter
            text: result.value + ' юдк.'
            font.pixelSize: pt(100)
        }
    }
    Button {
        text: 'Отмена'
        onClicked: api.codeDestroy(qrcode.value)
        width: view.width * 0.4
        height: pt(140)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: pt(100)
        visible: result.visible
    }
}
