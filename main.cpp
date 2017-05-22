#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView>

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("KochergaClub");
    app.setOrganizationDomain("http://kocherga-club.ru/");
    app.setApplicationName("Kocherga");

    QtWebView::initialize();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
