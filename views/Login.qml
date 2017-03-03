import QtQuick 2.7
import '../components'

View {
    anchors.fill: parent
    Column {
        anchors.centerIn: parent
        spacing: pt(40)
        Repeater {
            model: ['facebook', 'twitter', 'vkontakte', 'instagram']
            delegate: SocialButton {
                network: modelData
                onPressed: api.loggedIn = true
            }
        }
    }
}
