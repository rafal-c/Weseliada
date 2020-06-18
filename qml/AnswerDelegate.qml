import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: delegateID
    property var answerModel

    //width: delegateID.ListView.view.width
    width: parent.width
    height: checkDelegate.implicitHeight

    CheckDelegate {
        id: checkDelegate
        text: qsTr(answerModel.text + ".................(" + answerModel.points + ")")
        anchors.verticalCenter: parent.verticalCenter
        checkState: Qt.Unchecked
        display: AbstractButton.TextBesideIcon
    }
}


