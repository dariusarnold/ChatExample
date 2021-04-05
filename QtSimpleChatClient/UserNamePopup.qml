import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Window {
    id: popup
    // Accepted pressed by user, try to login with username
    signal accepted(string username)

    // Remove minimze/maximize buttons
    flags: Qt.Dialog | Qt.CustomizeWindowHint | Qt.WindowTitleHint | Qt.WindowCloseButtonHint
    modality: Qt.ApplicationModal
    title: qsTr("Choose a name")
    minimumHeight: layout.childrenRect.height
    minimumWidth: layout.childrenRect.width
    ColumnLayout {
        id: layout
        Item {
            Layout.preferredHeight: 8
        }
        TextField {
            id: username
            placeholderText: qsTr("Name")
            Layout.alignment: Qt.AlignHCenter
        }
        DialogButtonBox {
            standardButtons: DialogButtonBox.Cancel | DialogButtonBox.Ok
            onRejected: {
                popup.close()
            }
            onAccepted: {
                popup.accepted(username.text)
                popup.close()
            }
        }
    }
}
