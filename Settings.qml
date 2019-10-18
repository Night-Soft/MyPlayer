import QtQuick 2.4
//import QtQuick.Controls 2.3
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0


Item {
    id: settings
    width: 400
    height: 470
    property alias settings: settings
    property alias checkBox: checkBox
    objectName: "settings"
    signal playAtStart()
    Rectangle {
        width: 400
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#394c64"
            }

            GradientStop {
                position: 1
                color: "#212d3e"
            }
        }
    anchors.fill: parent

    }
    CheckBox {
        id: checkBox
        x: 5
        y: 5
        width: 390
        height: 40
        objectName: "chBxPlay"

        signal chBxSignal()
        style: CheckBoxStyle{
            label: Text {
            id: name
            text: qsTr("Play at startup")
            font.pointSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            color: "white"
        }
    }
        //signal playAtStart()
        onClicked: {
            chBxSignal()
            console.log("Click ok")

        }
    }
    Text {
        id: text1
        x: 135
        y: 377
        width: 131
        height: 50
        text: qsTr("Settings")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Courier"
        font.pixelSize: 28
        color: "white"
        z: 1
    }

}
