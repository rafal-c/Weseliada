import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: delegateID

    width: delegateID.ListView.view.width
    height: active? checkDelegate.implicitHeight : 0
    visible: active

    property color colorUp: "#2e3436"
    property color colorDown: "#17a81a"

    property int parentIndex

    enabled: active

    CheckDelegate {
        id: checkDelegate
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        display: AbstractButton.TextBesideIcon

        contentItem: Text {
            rightPadding: checkDelegate.indicator.width + checkDelegate.spacing
            font: checkDelegate.font
            opacity: enabled ? 1.0 : 0.3
            color: checkDelegate.down ? colorDown : colorUp
            text: "<table width=\"60%\"><tr><td width=\"50%\">" + model.text + "</td><td width=\"50%\" align=\"right\">" + model.points + "</td></tr></table>"
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            textFormat: Text.MarkdownText
        }

        indicator: Rectangle {
            id: checkboxID
            implicitWidth: 26
            implicitHeight: 26
            x: checkDelegate.width - width - checkDelegate.rightPadding
            y: checkDelegate.topPadding + checkDelegate.availableHeight / 2 - height / 2
            radius: 3
            border.color: "#2e3436"
            color: "transparent"

            Rectangle {
                width: 14
                height: 14
                x: 6
                y: 6
                radius: 2
                color: checkDelegate.down ? colorDown : colorUp
                visible: checkDelegate.checked
            }
        }

        Component.onCompleted: {
            checkDelegate.checkState = model.guessed? Qt.Checked : Qt.Unchecked
        }

        onCheckedChanged: {
            console.log("Checked answer to question " + parentIndex)
            if (checked) {
                model.guessed = true;
                answerAreaModelCpp.printAnswer(index, model.text, model.points)
            } else {
                model.guessed = false;
                answerAreaModelCpp.clearAnswer(index, model.points)
            }
        }
    }
}


