import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property var sidebarModel;

    Rectangle {
        anchors.fill: parent
        color: "darkgray"
    }

    ColumnLayout {
        spacing: 10
        anchors.fill: parent

        Image {
            id: smallXImageID
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            //Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.2
            fillMode: Image.PreserveAspectFit
            //anchors.centerIn: parent
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
                onClicked: sidebarModel.displaySmallX();
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
            //anchors.centerIn: parent
            //height: sourceSize.height/2.5
            source: "qrc:/images/error"

            MouseArea {
                anchors.fill: parent
                onPressedChanged: {
                    bigXImageID.opacity = pressed? 0.5 : 1
                }
                onClicked: sidebarModel.displayBigX();
            }
        }

        Button {
            id: button1
            text: qsTr("Wyczyść")
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
