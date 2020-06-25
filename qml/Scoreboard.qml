import QtQuick 2.15
import QtQuick.Layouts 1.11
import ScoreboardModel 1.0

Item {
    id: scoreboardID

    property int defaultSpacing: 10
    enabled: false

    Rectangle {
        id: rectangle
        color: "#040505"
        anchors.fill: parent
    }

    RowLayout {
        id: rowLayoutID
        spacing: mainAreaID.columnSpacing
        anchors {
            rightMargin: 20
            leftMargin: 20
            fill: parent
        }
        BoardView {
            id: leftSidebarID
            delegateWidth: mainAreaID.delegateWidth
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            model: leftSidebarModelCpp
            implicitWidth: Math.round(0.1 * parent.width)
        }

        BoardView {
            id: mainAreaID
            Layout.alignment: Qt.AlignCenter
            model: answerAreaModelCpp
            implicitWidth: parent.width - leftSidebarID.width - rightSidebarID.width
            font: "LED Calculator"
        }

        BoardView {
            id: rightSidebarID
            delegateWidth: mainAreaID.delegateWidth
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            model: rightSidebarModelCpp
            implicitWidth: Math.round(0.1 * parent.width)
        }
    }
}

