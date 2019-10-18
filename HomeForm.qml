import QtQuick 2.8
import QtQuick.Controls 2.1 as QQC2
import QtQuick.Controls 1.4 as QQC1
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import com.myinc.Ellipse 1.0


import "myfunctions.js" as MyScripts


QQC2.Page {
    width: 400
    height: 130
    property alias textNameSong: textNameSong
    property alias play: play

    //    property alias play: play
    //    font.capitalization: Font.MixedCase
    //    wheelEnabled: false
    //    focusPolicy: Qt.StrongFocus
    //    spacing: 0

    // title: qsTr("Home")
    Component.onCompleted: {
        delayTimer.start()
    }
    Timer {
    id: delayTimer
    interval: 1000
    onTriggered: {
        //MyScripts.runAnimDelay()
    }
    }
    Rectangle {
        x: 0
        y: 0
        width: 400
        height: 130
        //color: "#3c3e52"
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

        Image {
            id: previousSong
            x: 52
            y: 15
            width: 40
            height: 40
            source: "resources/images/previous.svg"
            objectName: "previousSong"
            signal previousSongSignal()
            MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                MyScripts.enter(parent)

            }
            onExited: {
                MyScripts.exit(parent)
            }
            onClicked: {
            previousSong.previousSongSignal()
            }
            }


        }

        Image {
            id: play
            x: 231
            y: 15
            width: 40
            height: 40
            source: "resources/images/playNew.svg"
            MouseArea {
                objectName: "playButton1"
                anchors.fill: parent
                signal playSignal()
                hoverEnabled: true
                onClicked: {
                    playSignal()
                    stop.source = "resources/images/stop.svg"
                    areaStop.hoverEnabled = true
                    areaStop.enabled = true

                }
                onEntered: {
                    MyScripts.enter(parent)

                }
                onExited: {
                    MyScripts.exit(parent)
                }
            }


        }

        QQC1.Slider {
            id: sliderDuration
            x: 36
            y: 90
            width: 320
            height: 40
            stepSize: 1
            maximumValue: 100
            tickmarksEnabled: false
            wheelEnabled: true
            value: 5

            style: SliderStyle {
                groove: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 8
                            color: "gray"
                            radius: 10

                        }
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: control.pressed ? "white" : "#53c5b9"
                            border.color: "#53c5b9"
                            border.width: 2
                            implicitWidth: 25
                            implicitHeight: 25
                            radius: 8
                        }
            }




        }
//        Ellipse {
//        width: 200
//        height: 200
//        color: "red"
//        }

        Image {
            id: stop
            x: 138
            y: 15
            width: 40
            height: 40
            source: "resources/images/stop.svg"
            MouseArea {
                id: areaStop
                objectName: "stopButton"
                signal stopSignal()

                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    MyScripts.enter(stop)

                }
                onExited: {
                    MyScripts.exit(stop)
                }
                onClicked: {
                    stopSignal()
                    stop.source = "/resources/images/stopActive.svg"
                    stop.width = 40
                    stop.height = 40
//                    stop.x += 5
//                    stop.y += 5
                    hoverEnabled = false
                    enabled = false

                }

            }
        }

        Image {
            id: nextSong
            x: 320
            y: 15
            width: 40
            height: 40
            source: "resources/images/next.svg"
            objectName: "nextSong"
            signal nextSongSignal()
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    MyScripts.enter(parent)

                }
                onExited: {
                    MyScripts.exit(parent)
                }
                onClicked: {
                nextSong.nextSongSignal()
                }
            }

        }

        Text {
            id: textNameSong
            x: 30
            y: 70
            width: 340
            color: "#ffffff"
            objectName: "nameSong"
            text: "dlya lyubitelej grupp 'Kipelov' i 'Ariya') - Going To The Run (original dlya kaver-versii0"
           // text: "dlya lyubitelej grupp 'Kipelov' i 'Ariya') - Going To The Run"
//            text: "dlya lyubitelej grupp 'Kipelov' i 'Ariyadfssdgdh"
            clip: false
            elide: Text.ElideNone
            font.pixelSize: 20
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap

            NumberAnimation on x {
                id: animNameSong
                //loops: Animation.Infinite
                //easing: Easing.InOutQuad
//                to:  textNameSong.width - textNameSong.contentWidth + textNameSong.x
                to:  textNameSong.width - textNameSong.contentWidth + textNameSong.x

                duration: textNameSong.contentWidth * 11
                easing.type: Easing.InOutQuad

                running: false
                onStopped: {
                    delayTimer.start()

                }

            }
            NumberAnimation on x {
            id:animNameSongReverse
            //to: textNameSong.width + textNameSong.contentWidth -textNameSong.x
            //to: textNameSong.x + textNameSong.width + textNameSong.contentWidth
            //Easing.type:
            to: textNameSong.contentWidth + textNameSong.x - textNameSong.width
            duration: textNameSong.contentWidth *11
            easing.type: Easing.InOutQuad
            running: false
            onStopped:  {
                delayTimer.start()
            }
            }



        }

        Text {
            id: textEnd
            x: 347
            y: 100
            width: 53
            height: 30
            color: "#ffffff"
            text: qsTr("0.50")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: textStart
            x: 0
            y: 100
            width: 40
            height: 30
            color: "#ffffff"
            text: qsTr("3.09")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        Rectangle {
            id: leftRect
            x: 0
            y: 62
            width: 40
            height: 40
            radius: 0
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "transparent"
                }

                GradientStop {
                    position: 0.500
                    color: "#3c3e52"
                }
            }
            border.width: 0
            rotation: 90
        }
        Rectangle {
        id: rightRect
        x: 360
        y: 62
        width: 40
        height: 40
        rotation: 90
        gradient: Gradient{
        GradientStop {
        position: 0.500
        color: "#3c3e52"


        }
        GradientStop {
            position: 1
            color: "transparent"
        }
        }
        }


        QQC1.Slider {
            id: sliderVolume
            x: 358
            y: 25
            width: 45
            height: 25
            stepSize: 1
            maximumValue: 100
            value: 20
            rotation: 270
            objectName: "sliderVolume"
            signal sliderVolumeSignal()
            onValueChanged: {
            sliderVolumeSignal()
//                if(value == 0){
//                handlee.color = "red"
//                }
            }
            style: SliderStyle {
                groove: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 8
                    color: "gray"
                    radius: 10
                }
                handle: Rectangle {
                    id: handlee
                    anchors.centerIn: parent
                    color: control.pressed ? "white"  : "#53c5b9"
                    border.color: "#53c5b9"
                    border.width: 2
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 5


                }
            }
//            MouseArea{
//            anchors.fill: parent
//            onClicked: {
//                sliderDuration.value = 20
//                textStart.text = "ok"
//                //handle.color = control.pressed ? "white"  : "#53c5b9"
//                sliderVolume.sliderVolumeSignal()
//            }
//            }
        }











    }












}
