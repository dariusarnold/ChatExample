#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QHostAddress>
#include "chatclient.h"


int main(int argc, char *argv[])
{
    QGuiApplication a(argc, argv);
    // Allocate singleton before engine to ensure singleton outlives it
    QScopedPointer<ChatClient> chatClient(new ChatClient);
    // Singleton instances have to be registered before loading main.qml, otherwise the
    // qml module (for the singleton) cannot be found
    qmlRegisterSingletonInstance("ChatApp.ChatClient", 1, 0, "ChatClient", chatClient.get());
    qmlRegisterSingletonInstance("ChatApp.ChatMessages", 1, 0, "ChatMessages", chatClient->model());
    //qmlRegisterType<QHostAddress>("Qt.Types", 1, 0, "QHostAddress");
    QQmlApplicationEngine engine;
    const auto url = QUrl(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &a,
                     [url](QObject* obj, const QUrl objUrl) {
        if (!obj && url == objUrl) QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return a.exec();
}
