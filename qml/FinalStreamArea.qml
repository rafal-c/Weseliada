import QtQuick 2.12
import QtMultimedia 5.12

Item {

    property alias cameraID: camera.deviceId
    property alias cameraState: camera.cameraState

    Camera {
        id: camera
        cameraState: Camera.UnloadedState
        captureMode: Camera.CaptureVideo
    }

    VideoOutput {
        source: camera
        focus : visible // to receive focus and capture key events when visible
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent;
            onClicked: camera.imageCapture.capture();
        }
    }

    Component.onCompleted: {
        console.log(camerasInfo())
        console.log(camera.deviceId)
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
