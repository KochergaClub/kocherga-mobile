#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "deps/QZXingFilter.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    app.setOrganizationName("KochergaClub");
    app.setOrganizationDomain("http://kocherga-club.ru/");
    app.setApplicationName("Kocherga");

    QQmlApplicationEngine engine;

    qmlRegisterType<QZXingFilter>("QZXing", 2, 3, "QZXingFilter");

    QQmlContext *context = engine.rootContext();
    #if defined(Q_OS_ANDROID)
        context->setContextProperty(QLatin1String("AppPlatform"), "android");
    #elif defined(Q_OS_WIN)
        context->setContextProperty(QLatin1String("AppPlatform"), "windows");
    #elif defined(Q_OS_OSX)
        context->setContextProperty(QLatin1String("AppPlatform"), "osx");
    #elif defined(Q_OS_LINUX)
        context->setContextProperty(QLatin1String("AppPlatform"), "linux");
    #elif defined(Q_OS_IOS)
        context->setContextProperty(QLatin1String("AppPlatform"), "ios");
    #elif defined(Q_OS_UNIX)
        context->setContextProperty(QLatin1String("AppPlatform"), "unix");
    #else
        context->setContextProperty(QLatin1String("AppPlatform"), "unknown");
    #endif
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
