import QtQuick 2.4
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
    id: gamePanelID
    property alias questionsListID: questionsListID
    implicitHeight: 50
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent
    }

    RowLayout {
        id: rowID
        anchors.fill: parent

        SidebarControlPanel {
            id: leftSidebarPanelID
            sidebarModel: leftSidebarModelCpp
            implicitWidth: 15
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ListView {
            id: questionsListID
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 20
            implicitWidth: 70
            model: questionListModelCpp
            delegate: QuestionDelegate {}
        }

        SidebarControlPanel {
            id: rightSidebarPanelID
            sidebarModel: rightSidebarModelCpp
            implicitWidth: 15
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

