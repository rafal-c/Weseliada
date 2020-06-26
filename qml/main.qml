import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12

QtObject {
    property var controlWindow: Window {
        id: scoreboardWindowID
        visible: false
        flags: Qt.WindowMaximizeButtonHint
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

//        onWidthChanged: {
//            gameBoardID.row.Scoreboard.forceLayout()
//        }
    }

    property var testWindow: ApplicationWindow {
        id: panelWindowID
        visible: true
        width: 1080
        height: 720
//        minimumWidth: gamePanelID.implicitWidth
//        minimumHeight: gamePanelID.height

        Action {
            id: quitActionID
            text: qsTr("&Quit")
            shortcut: "Ctrl+Q"
            onTriggered: Qt.quit()
        }

        header: ToolBar {
                RowLayout {
                    anchors.fill: parent
                    ToolButton {
                        text: qsTr("‹")
                        onClicked: stack.pop()
                    }
                    Label {
                        text: "Title"
                        elide: Label.ElideRight
                        horizontalAlignment: Qt.AlignHCenter
                        verticalAlignment: Qt.AlignVCenter
                        Layout.fillWidth: true
                    }
                    ToolButton {
                        text: qsTr("X")
                        onClicked: quitActionID.trigger()
                    }
                }
            }

//        menuBar: MenuBar {
//            Menu {
//                title: qsTr("&App")
//                Action {
//                    text: qsTr("&Show scoreboard")
//                    checkable: true
//                    shortcut: "Ctrl+F"
//                    onToggled: {
//                        scoreboardWindowID.visible = checked
//                        if (checked) {
//                            scoreboardWindowID.showMaximized()
//                            gameBoardID.boardReady()
//                        }
//                        scoreboardWindowID.setWidth(400)
//                        text = qsTr(checked? "&Hide scoreboard" : "&Show scoreboard")
//                    }
//                }
//                MenuSeparator { }

//            }
//        }

        Component.onCompleted: {
            setX(Screen.width / 2 - width / 2);
            setY(Screen.height / 2 - height / 2);
        }

        GamePanel {
            id: gamePanelID
            anchors {
                fill: parent
            }
        }

    }
}


