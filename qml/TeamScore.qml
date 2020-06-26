import QtQuick 2.12
import QtQuick.Layouts 1.11

Item {
    property alias teamName: teamNameID.text
    property alias scoreModel: scoreViewID.model
    property int score: 0

    Rectangle {
        id: rectangle
        color: "transparent"
        anchors.fill: parent
    }

    function digits(n) {
        n = Math.min(Math.max(0, n), 999);
        return Array.from(String(n), Number);
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Text {
            id: teamNameID
            text: qsTr("Team Name")
            Layout.fillWidth: true
            Layout.fillHeight: false
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignCenter
            font.pixelSize: 12
        }


        BoardView {
            id: scoreViewID
            Layout.alignment: Qt.AlignCenter
            implicitWidth: parent.width
        }

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:0}
D{i:2;anchors_height:100;anchors_width:100}
}
##^##*/
