import QtQuick 2.4

Item {
    implicitWidth: 50
    implicitHeight: 70
    property alias text: textID.text
    property alias textID: textID
    property alias fontFamily: textID.font.family

    Rectangle {
        id: rectangle
        color: "#000000"
        anchors.fill: parent
    }
    Text {
        id: textID
        width: 50
        height: 70
        color: "#fce94f"
        text: ""
        font.family: "écran monochrome / monochrome display"
        font.pointSize: 100
        visible: true
        font.capitalization: Font.AllUppercase
        elide: Text.ElideNone
        renderType: Text.QtRendering
        fontSizeMode: Text.HorizontalFit
        textFormat: Text.PlainText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}D{i:1;anchors_height:200;anchors_width:200;anchors_x:"-6";anchors_y:"-13"}
D{i:2;anchors_x:0;anchors_y:0}
}
##^##*/

