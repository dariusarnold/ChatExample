import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import ChatApp.ChatClient 1.0

GridLayout {
    columns: 2

    signal sendClicked(string text)
    signal connectToServer(string address)
    property bool isConnectedToServer: false

    onConnectToServer: {
        var addressValid = ChatClient.isAddressValid(address)
        if (!addressValid) {
            console.warn("Invalid address")
            return
        }
        ChatClient.connectToServer(address, 1967)
    }

    onSendClicked: {
        ChatClient.sendMessage(text)
        messageInput.clear()
    }

    Connections {
        target: ChatClient

        function onConnected() {
            console.info("Connected to server")
            isConnectedToServer = true
        }

        function onError(socketError) {
            console.warn("Connection failed (SocketError %1)".arg(socketError))
            isConnectedToServer = false
        }
    }

    Button {
        text: qsTr("Connect")
        Layout.columnSpan: 2
        Layout.fillWidth: true
        property var serverAddressSelection: ServerAddressPopup {
            onAccepted: connectToServer(address)
        }
        onClicked: serverAddressSelection.show()
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
        enabled: isConnectedToServer
    }
    Button {
        text: qsTr("Send")
        Layout.rightMargin: 8
        onClicked: sendClicked(messageInput.text)
        enabled: messageInput.text.length > 0 && isConnectedToServer
    }
}
