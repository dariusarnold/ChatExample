import QtQuick 2.12
import QtQuick.Controls 2.12
import ChatApp.ChatClient 1.0

ApplicationWindow {
    visible: true
    title: qsTr("Chat client")
    width: 640
    height: 480

    Chat {
        anchors.fill: parent

        onDisconnectFromServer: ChatClient.disconnectFromHost()
        onLoginToServer: ChatClient.login(username)
        onSendClicked: ChatClient.sendMessage(text)

        onConnectToServer: {
            var addressValid = ChatClient.isAddressValid(address)
            if (!addressValid) {
                console.warn("Invalid address")
                return
            }
            ChatClient.connectToServer(address, 1967)
            showUsernamePopup()
        }
    }
}
