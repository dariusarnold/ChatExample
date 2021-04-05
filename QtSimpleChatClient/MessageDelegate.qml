import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    property string messageText
    property string author
    // Display on the right side of the screen, indicating a message written by the current user
    property bool displayRight: false

    width: content.width + 16
    height: content.height + 16
    color: "lightgreen"
    anchors.right: displayRight ? parent.right : undefined

    Column {
        id: content
        anchors.centerIn: parent
        Label {
            text: messageText
        }

        Label {
            text: "    %1".arg(author.length > 0 ? author : qsTr("No author"))
            font.italic: true
        }
    }
}
