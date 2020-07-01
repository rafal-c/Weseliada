import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12

ColumnLayout {
    id: delegateID
    width: delegateID.ListView.view.width

    property int questionIndex: model.index
    spacing: 8
    //anchors.fill: parent
    RowLayout {
        id: rectangle
        Layout.fillWidth: true
        implicitHeight: questionTextID.implicitHeight + 10
        Button {
            id: pointsGoLeftButtonID
            text: "⬅ 💰"
            display: AbstractButton.TextOnly
            contentItem: Rectangle {
                color: "transparent"
                Text {
                    font.pointSize: 100
                    anchors.fill: parent
                    text: pointsGoLeftButtonID.text
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            onClicked: {
                answerAreaModelCpp.assignPoints(0)
            }
        }

        SoundEffect {
            id: questionIntroSoundID
            source: "qrc:/audio/question_intro"
        }

        Button {
            id: questionTextID
            text: qsTr(question)
            Layout.fillWidth: true
            onClicked: {
                console.log("Now solving " + questionIndex + ". " + model.question + " with " + model.answers.rowCount() + " answers.")
                leftSidebarModelCpp.clear();
                rightSidebarModelCpp.clear();
                if (questionListModelCpp.activeQuestion == questionIndex) {
                    questionListModelCpp.activeQuestion = -1
                    answerAreaModelCpp.clear()
                    return
                }
                questionIntroSoundID.play()
                questionListModelCpp.activeQuestion = questionIndex
                console.log("Active question is " + questionListModelCpp.activeQuestion)
                answerAreaModelCpp.prepareForQuestion(model.answers.rowCount());
            }
        }

        Button {
            id: pointsGoRightButtonID
            text: "💰 ➡"
            contentItem: Rectangle {
                color: "transparent"
                Text {
                    font.pointSize: 100
                    anchors.fill: parent
                    text: pointsGoRightButtonID.text
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            onClicked: {
                answerAreaModelCpp.assignPoints(1)
            }
        }
    }
    ListView {
        id: answersViewID
        Layout.fillHeight: true
        Layout.fillWidth: true
        implicitHeight: contentHeight
        model: answers
        delegate: AnswerDelegate {
            parentIndex: questionIndex
        }
    }
}





