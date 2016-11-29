import QtQuick 2.7
import QtQuick.Window 2.2

Button {
    width: pt(600)
    height: pt(150)
    radius: pt(20)
    leftPadding: height
    property string network: 'facebook'
    text: network
    highlighted: true
    pressedColorText: '#fff'
    pressedColor: Qt.darker(color, 1.1)
    color:  (network === 'facebook') ? '#3b5998' :
            (network === 'twitter') ? '#55acee' :
            (network === 'instagram') ? '#5b3e3c' :
            (network === 'foursquare') ? '#f94877' :
            (network === 'vkontakte') ? '#587ea3' :
            (network === 'google-plus') ? '#dd4b39' :
            (network === 'dropbox') ? '#1087dd' :
            '#888888'
    Image {
        antialiasing: true
        width: parent.height / 2
        height: width
        x: width / 2
        y: width / 2
        sourceSize.width: width * Screen.devicePixelRatio
        sourceSize.height: height * Screen.devicePixelRatio
        source: '../images/networks/' + network + '.svg'
        fillMode: Image.PreserveAspectFit
    }

    Component.onCompleted: {
        contentItem.horizontalAlignment = Text.AlignHLeft
    }
}
