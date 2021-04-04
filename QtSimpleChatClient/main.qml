import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    visible: true
    title: qsTr("Chat client")
    width: 640
    height: 480

    Chat {
        anchors.fill: parent
    }
}
