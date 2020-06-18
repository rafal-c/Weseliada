import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

ColumnLayout {
    id: delegateID
    implicitWidth: delegateID.ListView.view.width
    property var questionModel
    property var activeQuestion
    spacing: 8
    //anchors.fill: parent
    Rectangle {
        id: rectangle
        Layout.fillWidth: true
        implicitHeight: 20
        Button {
            id: questionTextID
            text: qsTr(questionModel.question)
            anchors.fill: parent
            onClicked: {
                console.log(questionModel.answers.count)
                answerAreaModelCpp.prepareForQuestion(6);
                console.log(answerAreaModelCpp.tileSpacing)
            }
        }
    }
    ListView {
        //Layout.fillHeight: true
        Layout.fillWidth: true
        implicitHeight: contentHeight
        spacing: 10
        model: ListModel {
            ListElement {
                text: "lama"
                points: 10
            }
            ListElement {
                text: "koza"
                points: 20
            }
        }
        delegate: AnswerDelegate {
            answerModel: model
        }
    }

}




/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
