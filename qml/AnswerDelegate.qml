import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: delegateID

    width: delegateID.ListView.view.width
    //width: checkDelegate.implicitWidth
    height: checkDelegate.implicitHeight

    property color colorUp: "#2e3436"
    property color colorDown: "#17a81a"
    CheckDelegate {
        id: checkDelegate
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        checkState: Qt.Unchecked
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

        onCheckedChanged: {
            if (checked) {
                answerAreaModelCpp.printAnswer(index, model.text, model.points)
            } else {
                answerAreaModelCpp.clearAnswer(index, model.points)
            }
        }
    }
}


