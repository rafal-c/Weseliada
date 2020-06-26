import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

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
            text: "<-"
            onClicked: {
                answerAreaModelCpp.assignPoints(0)
            }
        }

        Button {
            id: questionTextID
            text: qsTr(question)
            Layout.fillWidth: true
            onClicked: {
                console.log("Now solving " + model.index + ". " + model.question + " with " + model.answers.rowCount() + " answers.")
                questionListModelCpp.activeQuestion = model.index;
                console.log("Active question is " + questionListModelCpp.activeQuestion)
                answerAreaModelCpp.prepareForQuestion(model.answers.rowCount());
                leftSidebarModelCpp.clear();
                rightSidebarModelCpp.clear();
            }
        }

        Button {
            text: "->"
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





