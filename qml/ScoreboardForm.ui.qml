import QtQuick 2.12
import QtQuick.Layouts 1.11
import ScoreboardModel 1.0

Item {
    property alias mainAreaID: mainAreaID
    property alias mainAreaModel: mainAreaID.model
    property alias leftSidebarID: leftSidebarID
    property alias leftSidebarModel: leftSidebarID.model
    property alias rightSidebarID: rightSidebarID
    property alias rightSidebarModel: rightSidebarID.model
    property alias rowLayoutID: rowLayoutID

    enabled: false

    Rectangle {
        id: rectangle
        color: "#040505"
        anchors.fill: parent
    }

    RowLayout {
        id: rowLayoutID
        spacing: mainAreaModel.tileSpacing
        anchors.fill: parent

        TableView {
            id: leftSidebarID
            implicitWidth: contentWidth
            implicitHeight: contentHeight
            columnSpacing: model.tileSpacing
            rowSpacing: model.tileSpacing
            delegate: TextField {
                text: model.text
            }

            //Layout.fillHeight: true
            //Layout.preferredWidth: contentWidth
        }

        TableView {
            id: mainAreaID
            implicitWidth: contentWidth
            Layout.fillHeight: true
            columnSpacing: model.tileSpacing
            rowSpacing: model.tileSpacing
            delegate: TextField {
                text: model.text
                fontFamily: "LEDCalculator"
            }
        }

        TableView {
            id: rightSidebarID
            implicitWidth: contentWidth
            Layout.fillHeight: true
            columnSpacing: model.tileSpacing
            rowSpacing: model.tileSpacing
            delegate: TextField {
                text: model.text
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

