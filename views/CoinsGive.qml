import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import '../components'

View {
    id: view

    Component.onCompleted: {
        if (api.coins >= 1) {
            spinbox.value = 10;
        } else if (api.coins >= 0.1) {
            spinbox.value = 1;
        } else {
            stack.pop();
        }
    }

    Item {
        id: tumblers
        visible: !result.visible
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: actions.top
        anchors.bottomMargin: pt(100)
        Rectangle {
            color: '#fff'
            anchors.fill: parent
        }

        property bool inhibited: false
        function set(value) {
            tumblers.inhibited = true;
            tumbler0.currentIndex = Math.floor(value);
            tumbler1.currentIndex = Math.floor(value * 10) % 10;
            tumblers.inhibited = false;
        }

        Row {
            anchors.centerIn: parent
            height: parent.height
            Tumbler {
                id: tumbler0
                property int max: Math.floor(api.coins + 1e-10)
                model: Array.apply(null, new Array(max + 1)).map(function(x,i) { return i })
                width: pt(400)
                height: parent.height
                visibleItemCount: 5
                onCurrentIndexChanged: {
                    if (tumblers.inhibited) return;
                    spinbox.value = currentIndex * 10 + tumbler1.currentIndex
                }
            }
            Text {
                text: ','
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: pt(100)
                color: '#000'
            }
            Tumbler {
                id: tumbler1
                property int max: Math.min(9, Math.floor((api.coins - tumbler0.currentIndex + 1e-10) * 10))
                model: Array.apply(null, new Array(max + 1)).map(function(x,i) { return i })
                onMaxChanged: {
                    var index = currentIndex;
                    model = Array.apply(null, new Array(max + 1)).map(function(x,i) { return i })
                    if (model.length > index) {
                        currentIndex = index;
                    }
                }
                width: pt(400)
                height: parent.height
                visibleItemCount: 5
                onCurrentIndexChanged: {
                    if (tumblers.inhibited) return;
                    spinbox.value = tumbler0.currentIndex * 10 + currentIndex
                }
            }
        }
    }

    Item {
        id: actions
        visible: !result.visible
        width: view.width * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: pt(100)
        height: pt(140)
        SpinBox {
            id: spinbox
            from: 0
            value: 0
            to: api.coins * 10
            stepSize: 1

            property real realValue: value / 10
            onRealValueChanged: tumblers.set(realValue)

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
            visible: spinbox.realValue > 0 && spinbox.realValue <= api.coins
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
    Connections {
        target: window
        onBackButtonPressed: api.codeDestroy(qrcode.value)
    }
}
