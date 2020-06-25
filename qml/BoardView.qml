import QtQuick 2.15
import QtQuick.Layouts 1.12

TableView {
    id: mainAreaID

    property string font: "écran monochrome / monochrome display"

    property real delegateWidth: ((width + columnSpacing) / columns) - columnSpacing
    property real delegateHeight: delegateWidth * 7 / 5

    implicitHeight: Math.round((delegateHeight + rowSpacing) * rows)

    columnSpacing: model ? model.tileSpacing : defaultSpacing
    rowSpacing: model ? model.tileSpacing : defaultSpacing
    model: model
    delegate: TextField {
        id: delegate
        implicitWidth: mainAreaID.delegateWidth
        text: model.text
        fontFamily: font
    }

    onWidthChanged: {
        forceLayout();
    }
}
