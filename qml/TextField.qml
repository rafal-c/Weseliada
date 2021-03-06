import QtQuick 2.4

Item {
    id: textFieldID

    property alias text: textID.text
    property alias textID: textID
    property alias fontFamily: textID.font.family

    implicitHeight: implicitWidth * 7 / 5

    Rectangle {
        id: rectangle
        color: "#000000"
        anchors.fill: parent
    }

    Text {
        id: textID
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.fill: parent
        color: "#fce94f"
        text: ""
        font.pointSize: 100
        visible: true
        font.capitalization: Font.AllUppercase
        elide: Text.ElideNone
        renderType: Text.QtRendering
        fontSizeMode: Text.HorizontalFit
        textFormat: Text.PlainText
    }
}
