TEMPLATE = app

QT += qml quick svg websockets network quickcontrols2 multimedia webview

CONFIG += c++11 qzxing_multimedia

SOURCES += main.cpp

RESOURCES += qml.qrc

OTHER_FILES += \
    android/AndroidManifest.xml

include(deps/qzxing/src/QZXing.pri)

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
    QMAKE_ASSET_CATALOGS = ios/Images.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = AppIcon
    QMAKE_ASSET_CATALOGS_LAUNCH_IMAGE = LaunchImage
    QMAKE_IOS_DEPLOYMENT_TARGET = 8.0
    QMAKE_IOS_TARGETED_DEVICE_FAMILY = 1,2
    ios_launch.files = $$PWD/ios/Launch.xib
    QMAKE_BUNDLE_DATA += ios_launch
}

android {
    QT += androidextras
}

# See http://doc.qt.io/qt-5/opensslsupport.html for instructions how to build
# those libs and info why we need to
contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
        $$PWD/../../openssl/libcrypto.so \
        $$PWD/../../openssl/libssl.so
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
