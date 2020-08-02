import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtMultimedia 5.12

Item {
    property var sidebarModel;

    Rectangle {
        anchors.fill: parent
        color: "gray"
    }

    SoundEffect {
        id: wrongAnswerSoundID
        source: "qrc:/audio/resources/audio/wrong.wav"
    }

    SoundEffect {
        id: totalFailureSoundID
        source: "qrc:/audio/resources/audio/fail.wav"
    }

    ColumnLayout {
        spacing: 10
        anchors.fill: parent

        Image {
            id: smallXImageID
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: parent.height * 0.2
            fillMode: Image.PreserveAspectFit
            height: sourceSize.height/2.5
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            source: "qrc:/images/warning"

            MouseArea {
                anchors.fill: parent
                onPressedChanged: {
                    smallXImageID.opacity = pressed? 0.5 : 1
                }
                onClicked: {
                    wrongAnswerSoundID.play();
                    sidebarModel.displaySmallX();
                }
            }
        }

        Image {
            id: bigXImageID
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.2
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/error"

            MouseArea {
                anchors.fill: parent
                onPressedChanged: {
                    bigXImageID.opacity = pressed? 0.5 : 1
                }
                onClicked: {
                    totalFailureSoundID.play();
                    sidebarModel.displayBigX();
                }
            }
        }

        Button {
            id: button1
            text: qsTr("Clear")
            Layout.margins: 10
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: sidebarModel.clear();
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
