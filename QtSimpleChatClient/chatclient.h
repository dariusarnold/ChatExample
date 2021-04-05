#ifndef CHATCLIENT_H
#define CHATCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include "chatmessages.h"

class QHostAddress;
class QJsonDocument;

class ChatClient : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(ChatClient)

public:
    explicit ChatClient(QObject *parent = nullptr);
    Q_PROPERTY(QString userName MEMBER m_userName NOTIFY userNameChanged);
    Q_INVOKABLE bool isAddressValid(QString address);
    QAbstractItemModel* model();
public slots:
    void connectToServer(const QString &address, quint16 port);
    void login(const QString &userName);
    void sendMessage(const QString &text);
    void disconnectFromHost();
private slots:
    void onReadyRead();
signals:
    void connected();
    void loggedIn();
    void loginError(const QString &reason);
    void disconnected();
    void messageReceived(const QString &sender, const QString &text);
    void error(QAbstractSocket::SocketError socketError);
    void userJoined(const QString &username);
    void userLeft(const QString &username);
    void userNameChanged();
private:
    void addMessageToModel(const QString& sender, const QString& text);
    QTcpSocket *m_clientSocket;
    bool m_loggedIn;
    // Save username that was used for login
    QString m_userName;
    void jsonReceived(const QJsonObject &doc);
    // Store chat messages
    ChatMessageModel m_messages;
};

#endif // CHATCLIENT_H
