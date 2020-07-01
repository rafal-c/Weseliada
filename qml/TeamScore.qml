import QtQuick 2.12
import QtQuick.Layouts 1.11

Item {
    //property alias teamName: teamNameID.text
    property alias teamPicture: pictureID.source
    property alias scoreModel: scoreViewID.model
    property int score: 0

    Layout.fillHeight: true

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


//        Text {
//            id: teamNameID
//            text: qsTr("Team Name")
//            fontSizeMode: Text.VerticalFit
//            Layout.fillHeight: true
//            verticalAlignment: Text.AlignBottom
//            wrapMode: Text.WordWrap
//            font.pointSize: 80
//            font.capitalization: Font.MixedCase
//            Layout.fillWidth: true
//            horizontalAlignment: Text.AlignHCenter
//            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        //        }
        Rectangle {
            color: "transparent"
            implicitHeight: 0.2 * parent.height
            Layout.fillWidth: true
        }

        Image {
            id: pictureID
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            fillMode: Image.PreserveAspectFit
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        BoardView {
            id: scoreViewID
            implicitHeight: 0.5 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.fillWidth: true
        }

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
