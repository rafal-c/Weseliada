import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtMultimedia 5.12

ToolBar {
    property alias chosenScreen: screenChoiceID.currentIndex

    RowLayout {
        anchors.fill: parent
        Switch {
            id: showScoreboardSwitchID
            text: qsTr("Scoreboard visible")
            action: Action {
                shortcut: "Ctrl+F"
                onToggled: {
                    console.log("Current: ", screenInfo(scoreboardWindowID.screen), " chosen: ", screenChoiceID.currentText)
                    var scr = Qt.application.screens[chosenScreen]
                    scoreboardWindowID.screen = scr
                    scoreboardWindowID.setGeometry(scr.virtualX, scr.virtualY, scr.width, scr.height)
                    console.log("Set to: ", scoreboardWindowID.screen.virtualX, scoreboardWindowID.screen.virtualY)
                    if (checked) {
                        scoreboardWindowID.showFullScreen()
                    } else {
                        scoreboardWindowID.hide()
                    }
                }
            }
        }

        Label {
            text: "on"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }

        ComboBox {
            id: screenChoiceID
            Layout.fillWidth: true
            displayText: "Screen: " + currentText
            model: screensInfo()
        }


        ToolSeparator {
        }

        Label {
            text: qsTr("Intro + Lektor")
        }

        Audio {
            id: introMusicID
            source: "qrc:/audio/intro_lektor"
        }

        ToolButton {
            checkable: true
            text: "▶"
            onToggled: {
                if (checked) {
                    text = "⏸"
                    introMusicID.play();
                } else {
                    introMusicID.pause();
                    text = "▶️"
                }

            }
        }

        ToolSeparator {
        }

        Switch {
            id: streamFinalSwitchID
            text: qsTr("Stream final")
            action: Action {
                onToggled: {
                    scoreboardWindowID.finalStreamView.cameraID = QtMultimedia.availableCameras[cameraChoiceID.currentIndex].deviceId
                    scoreboardWindowID.finalStreamView.cameraState = checked? Camera.ActiveState : Camera.UnloadedState
                    scoreboardWindowID.finalStreamView.visible = checked
                }
            }
        }

        ComboBox {
            id: cameraChoiceID
            Layout.fillWidth: true
            displayText: "Camera: " + currentText
            model: camerasInfo()
        }

        ToolSeparator {
        }

        ToolButton {
            text: qsTr("X")
            onClicked: quitActionID.trigger()
        }


    }
}

