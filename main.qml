import QtQuick 2.8
import QtQuick.Controls 2.1

//import QtQuick.Controls.Styles 1.4

import "myfunctions.js" as MyScripts
//It was Window
Page {
    id: window
    visible: true
    width: 400
    height: 600
    title: "MyPlayer"


    NumberAnimation on width {
        id: anim
        target: searchInput
        properties: "width"
        from: 0
        to: 320

        duration: 1000
        running: false
        easing.type: Easing.OutQuad
    }

    NumberAnimation on x {
        id: animX
        target: searchInput
        properties: "x"
        from: 359
        to: 0;
        duration: 1000
        running: false
        easing.type: Easing.OutQuad

    }

    header: ToolBar {
        id: toolBar
        height: 36
        position: ToolBar.Header
        contentWidth: 0
        focusPolicy: Qt.StrongFocus
        wheelEnabled: true
        //        background: Rectangle{
        //        color: "#3C3E52"
        //        }
        //contentHeight: toolButton.implicitHeight





        Rectangle {
            //parent: textInput
            id: searchInput
            x: 39
            y: 0
            width: 0
            height: 36
            color: "white"
            //opacity: 30
            radius: 5
            border.width: 1
            border.color: "#63d5c4"

            TextInput {
                id: textInput
                width: 317
                height: 36
                font.weight: Font.Light
                renderType: Text.QtRendering
                maximumLength: 100
                cursorVisible: false
                font.pixelSize: 20
                selectByMouse: true
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                clip: true
                color: "black"
                autoScroll: true
                mouseSelectionMode: TextInput.SelectCharacters
                cursorPosition: 0

                MouseArea {
                    id: mouseAreaSearch
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    z: -1

                    onClicked: {
                        if(mouse.button === Qt.RightButton){
                            contextMenuSearch.popup()
                            //mouseAreaSearch.width = 400
                            //mouseAreaSearch.height = 600


                        }
                        if(mouse.button === Qt.LeftButton){
                            contextMenuSearch.close()
                            textInput.forceActiveFocus()
                            //mouseAreaSearch.width = 317
                            //mouseAreaSearch.height = 36
                        }
                    }


                    Menu {
                        id: contextMenuSearch
                        modal: true
                        MenuItem {
                            text: "Select All"
                            onClicked: {
                                textInput.selectAll()
                            }
                        }
                        MenuItem {
                            text: "Clear all"
                            onClicked: {
                                textInput.clear()
                            }
                        }
                        MenuItem {
                            text: "Cut"
                            onClicked: {
                                textInput.cut()
                            }
                        }
                        MenuItem {
                            text: "Copy"
                            onClicked: {
                                textInput.copy()
                            }
                        }
                        MenuItem {
                            text: "Paste"
                            onClicked: {
                                textInput.paste()
                            }

                        }
                    }
                }
            }

        }
        Rectangle {
            id: designer__Selection

            Image {
                id: searchIcon
                x: 345
                y: 0

                width: 55
                height: 36
                fillMode: Image.PreserveAspectCrop
                source: "resources/images/searchIcon.svg"
                smooth: true


                MouseArea {
                    x: 0
                    width: 32
                    height: 32
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 8
                    anchors.fill: parent
                    onClicked: {
                        if(MyScripts.i==1){
                            anim.from = 320
                            anim.to = 0
                            anim.easing.type = Easing.InQuad
                            animX.from = 34
                            animX.to = 359
                            animX.easing.type = Easing.InQuad
                            anim.start()
                            animX.start()
                            //textInput.text = "secondAnimOk"
                            MyScripts.searchDisabled()
                            //textInput.visible = false
                            textInput.enabled = false
                            textInput.cursorVisible = false

                        } else if(MyScripts.i == 0){
                            anim.from = 0
                            anim.to = 320
                            anim.easing.type = Easing.OutQuad
                            animX.from = 359
                            animX.to = 34
                            animX.easing.type = Easing.OutQuad
                            anim.start()
                            animX.start()
                            textInput.enabled = true
                            textInput.cursorVisible = true
                            textInput.forceActiveFocus()
                            //textInput.text = "firstAnimOk"
                            MyScripts.searchEnabled()
                        }

                    }
                }
            }
            Image {
                id: whiteField
                x: 359
                y: 0
                width: 0
                height: 36
                z: -1
                source: "resources/images/whiteField.png"
            }
        }



        ToolButton {
            id: toolButton
            x: 0
            y: 0
            width: 36
            height: 36
            text: "\u2630"
            padding: 0
            font.bold: false
            font.italic: false
            hoverEnabled: true
            enabled: true
            visible: true
            clip: false
            autoExclusive: false
            checked: false
            highlighted: false
            scale: 1
            wheelEnabled: true
            autoRepeat: true
            checkable: false
            font.pointSize: 24
            spacing: -2
            transformOrigin: Item.TopLeft
            font.family: "Times New Roman"


            onClicked: {
                if (stackView.depth > 1) {
                    settings.visible = false
                    stackView.pop()

                    toolButton.text = "\u2630"

                } else {
                    drawer.open()
                    toolButton.text = "\u2039"

                }
            }
        }


    }








    Drawer {
        id: drawer
        x: 0
        y: 0
        width: 340
        height: 600
        //        edge: Qt.RightEdge
        dragMargin: Qt.styleHints.startDragDistance
        //onClosed: toolButton.text = "\u2630"
        background: Rectangle {
            border.color: "transparent"
            border.width: 0
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#53c5b9"
                }

                GradientStop {
                    position: 1
                    color: "#4ab1a6"
                }
            }
            anchors.fill: parent

        }

        onClosed:
            if (stackView.depth > 1){
                toolButton.text = "\u2039"
            } else {
                toolButton.text = "\u2630"
            }


        Column {
            width: 340
            opacity: 1
            visible: true
            anchors.topMargin: 74
            anchors.fill: parent
            spacing: 5




            ListView {
                id: namePlayList
                width: 340
                height: 540
                focus: true
                objectName: "addFiless"

                signal addFilesSignal()
                highlight: Rectangle {
                    color: "#3C3E52"; radius: 5 }


                model: ListModel {
                    id: listmodel
                    objectName: "listmodell"
                    ListElement {
                        name: "Grey"
                        //colorCode: "grey"
                    }

                    ListElement {
                        name: "Red"
                        //colorCode: "red"
                    }

                    ListElement {
                        name: "Blue"
                        //colorCode: "blue"
                    }

                    ListElement {
                        //name: "Green"
                        name: "sfd"
                        //colorCode: "green"

                    }

                }
                delegate: Item {
                    id: item1
                    // x: 5
                    width: 340
                    height: 40
                    Rectangle {
                        id: rectangle1
                        color: "transparent"
                        radius: 3
                        width: parent.width
                        height: parent.height
                    }
                    Image {
                        width: 30
                        height: 30
                        y: 5
                        x: 5
                        source: "/resources/images/playlist.svg"
                        //color: colorCode
                        smooth: false
                        mipmap: true


                    }
                    Image {
                        id: add
                        width: 26
                        height: 26
                        y: 7
                        anchors.right: parent.right
                        anchors.rightMargin: 10

                        smooth: true
                        source: "/resources/images/add.svg"
                        visible: false
                        MouseArea {
                            width: 26
                            height: 26
                            onClicked: {
                                //nameEd.selectAll()
                                namePlayList.addFilesSignal()
                                //contextMenu.popup()
                            }
                        }
                    }
                    Rectangle {
                        id: rectEdit
                        y: 2
                        x: 37
                        width: 263
                        height: 36
                        color: "transparent"
                        radius: 5
                    }

                    TextInput {
                        id: nameEd
                        x: 2
                        color: "#ffffff"
                        text: name
                        cursorVisible: true
                        font.pointSize: 12
                        selectionColor: "#020080"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: false
                        enabled: false
                        leftPadding: 35
                        readOnly: true
                        maximumLength: 26
                        selectByMouse: true
                        onEditingFinished: {
                            nameEd.readOnly = true
                            rectEdit.color = "transparent"
                            nameEd.color = "#ffffff"
                        }


                    }
                    MouseArea {
                        id: mouseMEnu
                        anchors.fill: parent
                        z: -1
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        hoverEnabled: true

                        onEntered: {
                            rectangle1.color = "#4f5163"
                            add.visible = true

                        }
                        onExited: {
                            rectangle1.color = "transparent"
                            add.visible = false
                        }
                        onClicked: {
                            namePlayList.currentIndex = index
                            nameEd.enabled = true
                            add.visible = true
                            // currentIn = true
                            //MyScripts.newPlayList(Playlist.listmodel.count)

                            if(mouse.button === Qt.RightButton){
                                contextMenu.popup()

                            }


                        }



                        Menu {
                            id: contextMenu
                            MenuItem {
                                id: addF
                                text: "Add_files"

                                onClicked: {
                                    namePlayList.addFilesSignal()
                                }
                            }
                            MenuItem { text: "Rename"


                                onClicked: {
                                    rectEdit.color = "#ffffff"
                                    nameEd.color = "#000000"
                                    nameEd.readOnly = false
                                    nameEd.forceActiveFocus()

                                }
                            }
                            MenuItem { text: "Delete"
                                onClicked: {
                                    var deletedItem = namePlayList.currentIndex = index
                                    listmodel.remove(deletedItem)

                                }
                            }
                        }

                    }

                }
            }







        }

        Button {
            id: addPlayList
            x: 0
            y: 36
            width: 340
            height: 36
            //text: qsTr("+ new playlist ")

            font.pointSize: 15
            autoExclusive: false
            checked: false
            checkable: false
            Text {
                id: textAddPlayList
                anchors.fill: parent
                text: qsTr("+ new playlist ")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 14
                color: "white"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    rectangleBack.color = "#4f5163"
                }
                onExited: {
                    rectangleBack.color = "#3c3e52"
                }
                onClicked: {
                    MyScripts.mPlus()

                    textAddPlayList.text = "+ new playlist " + MyScripts.m
                    listmodel.append({
                                         "name": "Pizza Margarita " + MyScripts.m,
//                                         "colorCode": "grey"
                                     })
                }
            }
            background: Rectangle {
                id: rectangleBack
                color: "#3c3e52"
                radius: 0
                border.width: 3

                border.color: "#63d5c4"
            }


        }

        Button {
            id: settingsButton
            x: 0
            y: 0
            width: 340
            height: 36
            //text: qsTr("settings")
            Text {
                id: textSettingsBtn
                anchors.fill: parent
                text: qsTr("settings")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 14
                color: "white"
            }
            background: Rectangle {
                id: btnBackground
                color: "#3c3e52"
                radius: 0
                border.width: 3

                border.color: "#63d5c4"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        settings.visible = true
                        stackView.push("Settings.qml")



                        drawer.close()
                    }
                    onEntered: {
                        btnBackground.color = "#4f5163"
                    }
                    onExited: {
                        btnBackground.color = "#3c3e52"
                    }
                }
            }

        }





    }


    StackView {
        id: stackView
        x: 0
        y: 0
        width: 400
        height: 435
        anchors.bottomMargin: 129
        z: 0
        anchors.bottom: parent.bottom
        initialItem: "PlaylistPage.qml"

    }
    Settings {
        id: settings
        visible: false

    }
    HomeForm {
        id: homeForm
        x: 0
        y: 0
        width: 400
        height: 130
        z: 0
        anchors.bottom: parent.bottom

    }

}







/*##^## Designer {
    D{i:35;anchors_height:40;anchors_width:340}
}
 ##^##*/
