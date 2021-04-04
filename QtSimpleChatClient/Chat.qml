import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

GridLayout {
    columns: 2

    signal sendClicked(string text)
    signal connectToServer(string address)
    property bool isConnectedToServer: false

    Button {
        text: qsTr("Connect")
        Layout.columnSpan: 2
        Layout.fillWidth: true
        property var serverAddressSelection: Dialog {
            modal: true
            title: qsTr("Choose a server")
            standardButtons: Dialog.Cancel | Dialog.Ok
            TextField {
                id: input
                text: "127.0.0.1"
            }
            onAccepted: connectToServer(input.text)
        }
        onClicked: serverAddressSelection.open()
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
