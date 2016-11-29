import QtQuick 2.7
import '../components'

View {
    anchors.fill: parent
    Column {
        anchors.centerIn: parent
        spacing: 20
        Repeater {
            model: ['facebook', 'twitter', 'vkontakte', 'instagram']
            delegate: SocialButton {
                network: modelData
                onPressed: api.loggedIn = true
            }
        }
    }
}
