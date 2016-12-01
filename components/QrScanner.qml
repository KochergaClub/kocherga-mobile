import QtQuick 2.0
import QtMultimedia 5.7
import QZXing 2.3

VideoOutput {
    id: scanner
    source: camera
    fillMode: VideoOutput.PreserveAspectCrop
    autoOrientation: true

    property alias cameraState: camera.cameraState

    Camera {
        id: camera
    }

    filters: [ zxingFilter ]

    signal decodingStarted()
    signal decodingFinished(bool succeeded)
    signal tagFound(string tag)

    QZXingFilter {
        id: zxingFilter

        onDecodingStarted: scanner.decodingStarted()
        onDecodingFinished: scanner.decodingFinished(succeeded)
        onTagFound: scanner.tagFound(tag)
    }
}
