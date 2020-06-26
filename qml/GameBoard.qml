import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Item {
    id: elementID
    property alias row: rowLayoutID
//    width: rowLayoutID.childrenRect.width
//    height: rowLayoutID.childrenRect.height


    Rectangle {
        color: "#1c1f22"
        anchors.fill: parent
        Rectangle {
            id: rectangleID
            radius: 100
            anchors.fill: parent
            LinearGradient {
                anchors.fill: parent
                source: rectangleID
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, parent.height)
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#eca1fe"
                    }

                    GradientStop {
                        position: 0.52
                        color: "#b19fff"
                    }

                    GradientStop {
                        position: 1
                        color: "#5271c4"
                    }
                }
            }
        }
    }

    RowLayout {
        id: rowLayoutID
        anchors {
            margins: 20
            fill: parent
        }
        spacing: 20
        TeamScore {
            id: leftTeamID
            teamName: "Drużyna Panny Młodej"
            scoreModel: leftTeamScoreModelCpp
            implicitWidth: 0.1 * rowLayoutID.width
            implicitHeight: 0.2 * rowLayoutID.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
//            Layout.fillHeight: true
        }

        Scoreboard {
            id: myScoreID
            Layout.bottomMargin: 20
            Layout.topMargin: 20
            implicitWidth: 0.8 * rowLayoutID.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        TeamScore {
            id: rightTeamID
            teamName: "Drużyna Pana Młodego"
            scoreModel: rightTeamScoreModelCpp
            implicitWidth: 0.1 * rowLayoutID.width
            implicitHeight: 0.2 * rowLayoutID.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            //Layout.fillHeight: true
        }
    }


}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
