import QtQuick 2.0
import QtQuick.Controls 2.1
import "myfunctions.js" as MyScripts

VisualItemModel {
    id: visualItemModel
    property alias listView: listView
    property alias listmodel: listmodel

    ListView {
        id: listView
        x: 0
        y: 0
        width: 400
        height: 450
        objectName: "listFiles"
        flickableDirection: Flickable.AutoFlickDirection
        signal listFilesSignal()

        highlight: Rectangle {
            color: "#d2d2d2"
            radius: 5 }
        move: Transition {
                NumberAnimation { properties: "x,y"; duration: 1000 }
            }


        delegate: Item {
            id: delegate
            x: 0
            width: 400
            height: 36

            ListView.onRemove: SequentialAnimation {
                PropertyAction { target: delegate; property: "ListView.delayRemove"; value: true }
                ParallelAnimation {
                    NumberAnimation {target: delegate; property: "opacity"; to: 0; duration: 450 }
                    NumberAnimation {target: delegate; property: "x"; to: 400; duration: 600 }
                }
                NumberAnimation { target: delegate; property: "height"; to: 0; duration: 500; easing.type: Easing.InOutQuad }
                PropertyAction { target: delegate; property: "ListView.delayRemove"; value: false }
            }

            Row {
                id: row1
                width: 400
                height: 36
                layoutDirection: Qt.LeftToRight
                spacing: 5
                Rectangle {
                    id: rectangle1
                    color: "transparent"
                    radius: 3
                    width: parent.width
                    height: parent.height
                    Image {
                        width: 32
                        height: 32
                        y: 2
                        anchors.left: parent.left
                        //source: "resources/images/listIcon.svg"
                        source: sourceImage
                        smooth: true
                        anchors.leftMargin: 5
                    }
                    Text {
                        id: nameFile1
                        width: 380
                        height: 36
                        text: nameFile
                        elide: Text.ElideRight
                        clip: truncated
                        maximumLineCount: 1
                        font.bold: false
                        font.pointSize: 10
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.left: parent.left
                        anchors.leftMargin: 40

                    }
                    Text {
                        id: aboutFile
                        text: textAboutFile
                        anchors.left: parent.left
                        anchors.leftMargin: 40
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        font.pointSize: 8
                        font.weight: Font.Light
                    }
                    Text {
                        id: duration
                        text: durationText
                        color: "red"
                        font.pointSize: 10
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        font.weight: Font.ExtraLight
                        anchors.right: btn.left
                        anchors.rightMargin: 2
                    }


                    MouseArea {
                        id: mouseElement
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            MyScripts.shorteningTextAll(listmodel, listView)
                            listView.currentIndex = index

                        }
                        onDoubleClicked: {
                        //HomeForm.textNameSong.text = qsTr("sdf");


                        }

                        onEntered: {
                            rectangle1.color = "lightgrey"

                        }
                        onExited: {
                            rectangle1.color = "transparent"
                        }
                    }
                    CheckBox {
                    id: checkDelete
                    height: 32
                    width: 32
                    anchors.leftMargin: 5
                    onCheckedChanged: {


                    }

                    onToggled: {
                        var deletedItem = [];
                        deletedItem += listView.currentIndex = index
                        MyScripts.callDeleteItem(deletedItem);

                        console.log(deletedItem.toString());
                    }
                    }
                    Button {
                        id: btn
                        width: 20
                        height: 36
                        anchors.right: parent.right
                        //text: "\uFE19"
                        text: btnText
                        autoRepeat: true
                        hoverEnabled: true
                        focusPolicy: Qt.WheelFocus
                        display: AbstractButton.TextOnly
                        font.pointSize: 15
                        background: Image {
                            id: name
                            anchors.centerIn: parent
                            width: 18
                            height: 18
                            source: "/resources/images/down.svg"
                        }
                        onClicked: {
                        contextMenu.popup()
                        }
                        Menu {
                            id: contextMenu
                            modal: true
                            MenuItem {
                                id: addF
                                text: "Add_files"

                                onClicked: {
                                    namePlayList.addFilesSignal()
                                    listView.listFilesSignal()

                                }
                            }
                            MenuItem {
                                text: "Rename"
                                onClicked: {
                                    var rename = listView.currentIndex = index
                                    MyScripts.add();
                                    //listmodel.insert(rename, {"nameFile": "namefile", "durationText": "duration", "textAboutFile": "about", "sourceImage": "/resources/images/listIcon.svg"})
                                }
                            }
                            MenuItem { text: "Delete"
                                onClicked: {
                                    MyScripts.deleteItem();
                                    //var deletedItem = listView.currentIndex = index
                                    //listmodel.remove(deletedItem)
                                    //listmodel.hasChildren(parent)
                                    //listmodel.parent()
                                }
                            }
                        }

                    }

                }

            }
        }
        model: ListModel {
            id: listmodel
            objectName: "listModel"

            ListElement {
                nameFile: "Folder"
                durationText: "4.52"
                textAboutFile: "about"
                //btnText: "\uFE3D"
                sourceImage: "/resources/images/folder.svg"

            }

            ListElement {
                nameFile: "Golden Earring (dlya lyubitelej grupp 'Kipelov' i 'Ariya') - Going To The Run (original dlya kaver-versii 'Bespechnyj angel' ).mp3"
                durationText: "4.52"
                textAboutFile: "MP3 44KHZ 320 kbps 8.85 MB"
                btnText: "\uFE19"
                sourceImage: "/resources/images/listIcon.svg"

            }

            ListElement {
                nameFile: "Blue"
                durationText: "4.52"
                textAboutFile: "about"
                sourceImage: "/resources/images/listIcon.svg"


            }

            ListElement {
                nameFile: "Green"
                durationText: "4.52"
                textAboutFile: "about"
                sourceImage: "/resources/images/listIcon.svg"


            }
        }
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            //hoverEnabled: true
            enabled: false
            onEntered: {

            }
            onClicked: {
                var inn = listView.currentIndex = index
                if(mouse.button === Qt.LeftButton){
                    var str = new String (listmodel.get(inn).nameFile);
                    //listmodel.insert(3, {"nameFile": str.length.toString(), "durationText":"0" , "textAboutFile": "dfsddf"});

                    if (str.length > 47){
                        for(var i = str.length; i > 48; i--){
                            str = str.slice(0, -1)
                        }
                        str = str.concat("...");
                        listmodel.insert(0, {"nameFile": str.toString(), "durationText": str.length.toString(), "textAboutFile": "dfsddf"});


                    }
                    //listmodel.insert(1, {"nameFile": MyScripts.shorteningText(listmodel.get(1).nameFile), "durationText":"234"});
                    //listmodel.insert(0, {"nameFile": listmodel.get(1).nameFile, "durationText":"0", "textAboutFile": "dfsddf"});
                    //listmodel.insert(0, {"nameFile": str + " " + str.length, "durationText":"0", "textAboutFile": "dfsddf"});
                    //console.log(listmodel.get(1).nameFile);

                }
            }
        }


    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
