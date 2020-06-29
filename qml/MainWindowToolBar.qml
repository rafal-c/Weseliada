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
            text: qsTr("Show Scoreboard")
            action: Action {
                shortcut: "Ctrl+F"
                onToggled: {
                    console.log(screenInfo(scoreboardWindowID.screen))
                    scoreboardWindowID.visible = checked
                    if (checked) {
                        scoreboardWindowID.showMaximized()
                    }
                    showScoreboardSwitchID.text = qsTr(checked? "Hide scoreboard" : "Show scoreboard")
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
            source: "qrc:/audio/intro"
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

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
