import QtQuick 2.4

Item {
    id: textFieldID
    //implicitWidth: 50
    implicitHeight: implicitWidth * 7 / 5
    property alias text: textID.text
    property alias textID: textID
    property alias fontFamily: textID.font.family

    Rectangle {
        id: rectangle
        color: "#000000"
        anchors.fill: parent
    }

    MouseArea {
        id: mouseID
        anchors.fill: parent
    }

    Text {
        id: textID
        //        width: 50
        //        height: 70
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

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:480;width:640}D{i:1;anchors_height:200;anchors_width:200;anchors_x:"-6";anchors_y:"-13"}
}
##^##*/

