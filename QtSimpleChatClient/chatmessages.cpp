#include "chatmessages.h"

ChatMessage::ChatMessage(const QString& author, const QString& message) :
    m_author(author),
    m_messageText(message) {}

ChatMessageModel::ChatMessageModel(QObject* parent) : QAbstractListModel(parent) {}

void ChatMessageModel::addMessage(const QString &author, const QString &text) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_messages << ChatMessage{author, text};
    endInsertRows();
}

int ChatMessageModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_messages.count();
}

QVariant ChatMessageModel::data(const QModelIndex &index, int role) const {
    if (index.row() < 0 || index.row() >= m_messages.count()) {
        return QVariant();
    }
    const auto& msg = m_messages[index.row()];
    switch (role) {
    case AuthorRole:
        return msg.author();
    case MessageTextRole:
        return msg.messageText();
    }
    return QVariant();
}

QHash<int, QByteArray> ChatMessageModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[AuthorRole] = "author";
    roles[MessageTextRole] = "messageText";
    return roles;
}
