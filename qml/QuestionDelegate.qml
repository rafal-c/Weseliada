import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

ColumnLayout {
    id: delegateID
    implicitWidth: delegateID.ListView.view.width

    property bool isActiveQuestion: (questionListModelCpp.activeQuestion === model.index)
    spacing: 8
    //anchors.fill: parent
    Rectangle {
        id: rectangle
        Layout.fillWidth: true
        implicitHeight: questionTextID.implicitHeight + 10
        Button {
            id: questionTextID
            text: qsTr(question)
            anchors.fill: parent
            onClicked: {
                console.log("Now solving " + model.index + ". " + model.question + " with " + model.answers.rowCount() + " answers.")
                questionListModelCpp.activeQuestion = model.index;
                console.log("Active question is " + questionListModelCpp.activeQuestion)
                answerAreaModelCpp.prepareForQuestion(model.answers.rowCount());

            }
        }
    }
    ListView {
        Layout.fillWidth: true
        implicitHeight: contentHeight
        spacing: 10
        model: answers
        delegate: AnswerDelegate {
            enabled: isActiveQuestion
        }
    }

}




/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
