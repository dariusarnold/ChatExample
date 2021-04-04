#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "chatwindow.h"


int main(int argc, char *argv[])
{
    QGuiApplication a(argc, argv);
    QQmlApplicationEngine engine;
    const auto url = QUrl(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &a,
                     [url](QObject* obj, const QUrl objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    //ChatWindow chatWin;
    //chatWin.show();
    return a.exec();
}
