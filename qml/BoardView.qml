import QtQuick 2.15
import QtQuick.Layouts 1.12

TableView {
    id: mainAreaID

    property string font: "écran monochrome / monochrome display"

    property int defaultSpacing: 10
    property real delegateWidth: ((width + columnSpacing) / columns) - columnSpacing
    property real delegateHeight: delegateWidth * 7 / 5

    implicitHeight: Math.round((delegateHeight + rowSpacing) * rows)

    columnSpacing: model ? model.tileSpacing : defaultSpacing
    rowSpacing: model ? model.tileSpacing : defaultSpacing
    model: model
    delegate: TextField {
        id: delegate
        implicitWidth: delegateWidth > 0? delegateWidth : 50
        text: model.text
        fontFamily: font
    }

    Rectangle {
        color: "#040505"
        width: parent.childrenRect.width
        height: parent.childrenRect.height
    }

//    onWidthChanged: {
//        forceLayout();
//    }

    //TODO: find better way
    Timer {
        repeat: true
        running: true
        onTriggered: {
            forceLayout()
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
