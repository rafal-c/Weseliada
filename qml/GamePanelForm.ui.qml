import QtQuick 2.4
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
    id: gamePanelID
    implicitHeight: 50
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent
    }

    RowLayout {
        id: row
        anchors.fill: parent

        SidebarControlPanel {
            id: leftSidebarPanelID
            sidebarModel: leftSidebarModelCpp
            implicitWidth: 20
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ListView {
            id: questionsListID
            Layout.fillHeight: true
            Layout.fillWidth: true
            implicitWidth: 60
            implicitHeight: contentHeight
            delegate: QuestionDelegate {
                id: col1
                questionModel: model
            }
            model: ListModel {
                ListElement {
                    question: "Więcej niż jedno zwierzę"
                    answers: [
                        ListElement {
                            text: "lama"
                            points: 10
                        },
                        ListElement {
                            text: "koza"
                            points: 20
                        }
                    ]
                }

                ListElement {
                    question: "Więcej niż jedno zwierzę"
                    answers: [
                        ListElement {
                            text: "lama"
                            points: 10
                        },
                        ListElement {
                            text: "koza"
                            points: 20
                        }
                    ]
                }
                ListElement {
                    question: "Więcej niż jedno zwierzę"
                    answers: [
                        ListElement {
                            text: "lama"
                            points: 10
                        },
                        ListElement {
                            text: "koza"
                            points: 20
                        }
                    ]
                }

                ListElement {
                    question: "Więcej niż jedno zwierzę"
                    answers: [
                        ListElement {
                            text: "lama"
                            points: 10
                        },
                        ListElement {
                            text: "koza"
                            points: 20
                        }
                    ]
                }
            }
        }

        SidebarControlPanel {
            id: rightSidebarPanelID
            sidebarModel: rightSidebarModelCpp
            implicitWidth: 20
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

