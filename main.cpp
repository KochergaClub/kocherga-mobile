#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtWebView>

#include "deps/qzxing/examples/QZXingLive/QZXingFilter.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    app.setOrganizationName("KochergaClub");
    app.setOrganizationDomain("http://kocherga-club.ru/");
    app.setApplicationName("Kocherga");

    QtWebView::initialize();

    QQmlApplicationEngine engine;
    qmlRegisterType<QZXingFilter>("QZXing", 2, 3, "QZXingFilter");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
