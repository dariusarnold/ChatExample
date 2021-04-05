import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Window {
    id: popup
    // Accepted pressed by user, try to connect to address
    signal accepted(string address)
    // Remove minimze/maximize buttons
    flags: Qt.Dialog | Qt.CustomizeWindowHint | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    modality: Qt.ApplicationModal
    title: qsTr("Choose a server")
    minimumHeight: layout.childrenRect.height
    minimumWidth: layout.childrenRect.width
    ColumnLayout {
        id: layout
        Item {
            Layout.preferredHeight: 8
        }
        TextField {
            id: input
            text: "127.0.0.1"
            Layout.alignment: Qt.AlignHCenter
        }
        DialogButtonBox {
            standardButtons: DialogButtonBox.Cancel | DialogButtonBox.Ok
            onRejected: {
                popup.close()
            }
            onAccepted: {
                popup.accepted(input.text)
                popup.close()
            }
        }
    }
}
