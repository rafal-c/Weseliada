import QtQuick 2.4

GamePanelForm {
    Component.onCompleted: {
        console.log(questionListModelCpp.rowCount())
    }

//    MouseArea {
//        id: mouse
//        anchors.fill: parent
//        onClicked: {
//            //questionListModelCpp.readQuestionsFromFile(":/data/questions.json");
//            console.log(questionListModelCpp.rowCount())
//            console.log(questionsListID.count)
//        }
//    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
