import QtQuick 2.12
import QtQuick.Layouts 1.11

Item {
    property alias teamName: teamNameID.text
    Rectangle {
        id: rectangle
        color: "transparent"
        anchors.fill: parent
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Text {
            id: teamNameID
            text: qsTr("Team Name")
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 12
        }

        RowLayout {
            id: row
            spacing: 2
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            TextField {
                id: textField
            }

            TextField {
                id: textField1
            }

            TextField {
                id: textField2
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:0}
D{i:2;anchors_height:100;anchors_width:100}
}
##^##*/
