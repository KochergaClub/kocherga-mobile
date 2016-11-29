import QtQuick 2.0
import '../deps/qrcode.js' as Lib

Image {
    property string value: ''
    property int type: 4
    property int level: 2 // 1 - 4

    function refresh() {
        var levels = ['L','M','Q','H'];
        var qr = Lib.qrcode(type, levels[level - 1]);
        qr.addData(value);
        qr.make();
        source = qr.createImgTag(4, 1).replace(/.*"data:/, "data:").replace(/".*/, '');
    }

    onValueChanged: refresh()
    onTypeChanged: refresh()
    onLevelChanged: refresh()

    antialiasing: false
    smooth: false
    fillMode: Image.PreserveAspectFit

    Component.onCompleted: refresh()
}
