#pragma once

#include <QString>
#include <QObject>
#include <QAbstractListModel>


class ChatMessage {
public:
    ChatMessage(const QString& author, const QString& message);
    QString author() const {return m_author;};
    QString messageText() const {return m_messageText;}
private:
    QString m_author;
    QString m_messageText;
};


class ChatMessageModel: public QAbstractListModel {
    Q_OBJECT
public:
    enum ChatMessageRoles {
        AuthorRole = Qt::UserRole + 1,
        MessageTextRole
    };
    ChatMessageModel(QObject* parent = nullptr);
    void addMessage(const QString& author, const QString& text);
    int rowCount(const QModelIndex& parent = QModelIndex()) const;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const;
protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<ChatMessage> m_messages;
};
