import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12

QtObject {
    property var controlWindow: Window {
        id: scoreboardWindowID
        visible: false
        minimumWidth: gameBoardID.implicitWidth
        minimumHeight: gameBoardID.implicitHeight
        //maximumHeight: minimumHeight
        //maximumWidth: minimumWidth
    //    flags: Qt.FramelessWindowHint
        title: qsTr("Tablica wyników")


//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                console.debug(width)
//               // console.debug(myScoreID.rowLayoutID.childrenRect.width)
//            }
//        }

        GameBoard {
            id: gameBoardID
            anchors.fill: parent
        }

        Action {
            text: qsTr("&Quit")
            shortcut: "Ctrl+Q"
            onTriggered: Qt.quit()
        }

    }

    property var testWindow: ApplicationWindow {
        id: panelWindowID
        visible: true
        width: 1080
        height: 720
//        minimumWidth: gamePanelID.implicitWidth
//        minimumHeight: gamePanelID.height

        menuBar: MenuBar {
            Menu {
                title: qsTr("&App")
                Action {
                    text: qsTr("&Show scoreboard")
                    checkable: true
                    shortcut: "Ctrl+F"
                    onToggled: {
                        scoreboardWindowID.visible = checked
                        text = qsTr(checked? "&Hide scoreboard" : "&Show scoreboard")
                    }
                }
                MenuSeparator { }
                Action {
                    text: qsTr("&Quit")
                    shortcut: "Ctrl+Q"
                    onTriggered: Qt.quit()
                }
            }
        }

        Component.onCompleted: {
            setX(Screen.width / 2 - width / 2);
            setY(Screen.height / 2 - height / 2);
        }

        GamePanel {
            id: gamePanelID
            anchors.fill: parent
        }

    }
}


