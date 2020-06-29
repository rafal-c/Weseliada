import QtQuick 2.12
import QtMultimedia 5.12

Item {
//    Rectangle {
//        color: "white"
//        anchors.fill: parent
//    }
    property alias cameraID: camera.deviceId
    property alias cameraState: camera.cameraState

    Camera {
        id: camera
        cameraState: Camera.UnloadedState
        captureMode: Camera.CaptureVideo
        imageCapture {
            onImageCaptured: {
                // Show the preview in an Image
                photoPreview.source = preview
            }
        }

        onCameraStatusChanged: {
            console.log("Camera status is now: ", cameraStatus)
        }

        onCameraStateChanged: {
            console.log("Camera state is now: ", cameraState)
        }
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

//    ListView {
//        anchors.fill: parent

//        model: QtMultimedia.availableCameras
//        delegate: Text {
//            text: cameraInfo(modelData)

//            MouseArea {
//                anchors.fill: parent
//                onClicked: camera.deviceId = modelData.deviceId
//            }
//        }
//    }

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
