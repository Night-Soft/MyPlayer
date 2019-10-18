import QtQuick 2.8
import QtQuick.Controls 2.1

Page {
    width: 400
    height: 600

    title: qsTr("Page 1")
    Rectangle {
    anchors.fill: parent
    color: "#e0e0e0"

    }
    Column {
        id: column
        z: 0
        spacing: 0
        anchors.bottomMargin: 0
        anchors.fill: parent
        //spacing: 0
        Repeater {
            model: Playlist{}

        }
    }

}
