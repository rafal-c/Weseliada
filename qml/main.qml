import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtQuick.Layouts 1.12
import QtMultimedia 5.12

QtObject {
    property var controlWindow: Window {
        id: scoreboardWindowID
        visible: false
        //flags: Qt.FramelessWindowHint
        title: qsTr("Tablica wyników")
        //screen: Qt.application.screens[1]//panelWindowID.toolbar.chosenScreen]

        property alias finalStreamView: gameBoardID.finalStreamArea
        GameBoard {
            id: gameBoardID
            anchors.fill: parent
        }

        Action {
            text: qsTr("&Quit")
            shortcut: "Ctrl+Q"
            onTriggered: Qt.quit()
        }
    }

    function screenInfo(screen) {
        var text = "";
        if(screen.manufacturer) {
            text += screen.name
        } else if(screen.name) {
            text += screen.manufacturer
        } else {
            text += "Unknown"
        }
        if (screen.serialNumber) {
            text += " (" + screen.serialNumber + ")"
        }
        return text;
    }

    function screensInfo() {
        var allScreens = [];
        var s = Qt.application.screens;
        for (var i = 0; i < s.length; ++i)
            allScreens.push(s[i]);
        return allScreens.map(screenInfo)
    }


    function cameraInfo(camera) {
        var text = "";
        if(camera.displayName) {
            text += camera.displayName
        } else {
            text += "Unknown"
        }
        if (camera.deviceId) {
            text += " (" + camera.deviceId + ")"
        }
        return text;
    }

    function camerasInfo() {
        var allCameras = [];
        var s = QtMultimedia.availableCameras
        for (var i = 0; i < s.length; ++i)
            allCameras.push(s[i]);
        return allCameras.map(cameraInfo)
    }

    property var testWindow: ApplicationWindow {
        id: panelWindowID


        Material.theme: Material.Dark
        Material.accent: Material.Indigo

        property alias toolbar: toolbarID
        visible: true
        width: 1080
        height: 720
        screen: Qt.application.screens[0]

        Action {
            id: quitActionID
            text: qsTr("&Quit")
            shortcut: "Ctrl+Q"
            onTriggered: Qt.quit()
        }

        header: MainWindowToolBar{
            id: toolbarID
        }

//        menuBar: MenuBar {
//            Menu {
//                title: qsTr("&App")

//                MenuSeparator { }

//            }
//        }

        Component.onCompleted: {
            setX(Screen.width / 2 - width / 2);
            setY(Screen.height / 2 - height / 2);
        }

        GamePanel {
            id: gamePanelID
            anchors {
                fill: parent
            }
        }

    }
}


