TEMPLATE = app

QT += qml quick widgets svg websockets network quickcontrols2

SOURCES += main.cpp

RESOURCES += qml.qrc

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
    ios_assets.files = $$files($$PWD/ios/*.xcassets)
    ios_launch.files = $$PWD/ios/Launch.xib
    QMAKE_BUNDLE_DATA += ios_assets ios_launch
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
