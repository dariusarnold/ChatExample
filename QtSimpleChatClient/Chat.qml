import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import ChatApp.ChatClient 1.0

GridLayout {
    columns: 2

    // Send on input textfield clicked, now send text to server
    signal sendClicked(string text)
    // Try to connect to server with address
    signal connectToServer(string address)
    // Show popup prompting for username after server connection
    signal showUsernamePopup
    // Tro to login to server with given username
    signal loginToServer(string username)
    signal disconnectFromServer
    property bool isConnectedToServer: false
    property bool isLoggedIn: false

    onSendClicked: messageInput.clear()
    onShowUsernamePopup: userNameSelection.show()

    property var serverAddressSelection: ServerAddressPopup {
        onAccepted: {
            console.info("Connecting to %1".arg(address))
            close()
            connectToServer(address)
        }
    }

    property var userNameSelection: UserNamePopup {
        onAccepted: {
            console.info("Logging in as %1".arg(username))
            loginToServer(username)
        }
    }

    Connections {
        target: ChatClient

        function onConnected() {
            console.info("Connected to server")
            isConnectedToServer = true
        }

        function onDisconnected() {
            console.info("Disconnected from server")
            isConnectedToServer = false
            isLoggedIn = false
        }

        function onLoggedIn() {
            console.info("Logged in")
            isLoggedIn = true
        }

        function onError(socketError) {
            console.warn("Connection failed (SocketError %1)".arg(socketError))
            isConnectedToServer = false
        }

        function onLoginError(reason) {
            console.warn("Login failed: %1".arg(reason))
        }
    }

    Button {
        text: qsTr("Connect")
        Layout.columnSpan: 2
        Layout.fillWidth: true
        onClicked: serverAddressSelection.show()
    }
    Button {
        text: qsTr("Disconnect")
        Layout.columnSpan: 2
        Layout.fillWidth: true
        onClicked: disconnectFromServer()
        visible: isConnectedToServer
    }

    ListView {
        Layout.columnSpan: 2
        Layout.fillWidth: true
        Layout.fillHeight: true
        delegate: Text {}
    }
    TextField {
        id: messageInput
        Layout.fillWidth: true
        Layout.leftMargin: 8
        Layout.rightMargin: 8
        enabled: isConnectedToServer && isLoggedIn
    }
    Button {
        text: qsTr("Send")
        Layout.rightMargin: 8
        onClicked: sendClicked(messageInput.text)
        enabled: messageInput.text.length > 0 && isConnectedToServer
                 && isLoggedIn
    }
}
