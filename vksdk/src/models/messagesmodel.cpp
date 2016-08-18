#include "messagesmodel.h"

MessagesModel::MessagesModel(QObject *parent) : QAbstractListModel(parent)
{}

int MessagesModel::rowCount(const QModelIndex &parent) const {
    if (parent.isValid()) return 0;
    return _messages.size();
}

QVariant MessagesModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) return QVariant();

    Message *message = _messages.at(index.row());

    switch (role) {
    case IdRole:
        return QVariant(message->id());

    case DateRole:
        return QVariant(message->date());

    case IsOutRole:
        return QVariant(message->out());

    case IsReadRole:
        return QVariant(message->readState());

    case BodyRole:
        return QVariant(message->body());

    case PhotosRole:
        return message->photos();

    case VideosRole:
        return message->videos();

    case AudiosRole:
        return message->audios();

    case DocumentsRole:
        return message->documents();

    case NewsRole:
        return message->news();

    case GeoTileRole:
        return QVariant(message->geoTile());

    case GeoMapRole:
        return QVariant(message->geoMap());

    case FwdMessagesRole:
        return message->fwdMessages();

    default:
        return QVariant();
    }
}

QHash<int, QByteArray> MessagesModel::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[AvatarRole] = "avatar";
    roles[IdRole] = "id";
    roles[DateRole] = "datetime";
    roles[IsOutRole] = "out";
    roles[IsReadRole] = "read";
    roles[BodyRole] = "body";
    roles[PhotosRole] = "photosList";
    roles[VideosRole] = "videosList";
    roles[AudiosRole] = "audiosList";
    roles[DocumentsRole] = "documentsList";
    roles[NewsRole] = "newsList";
    roles[GeoTileRole] = "geoTileUrl";
    roles[GeoMapRole] = "geoMapUrl";
    roles[FwdMessagesRole] = "fwdMessagesList";
    return roles;
}

void MessagesModel::clear() {
    beginRemoveRows(QModelIndex(), 0, _messages.size());
    _messages.clear();
    endRemoveRows();

    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}

void MessagesModel::add(Message *message) {
    beginInsertRows(QModelIndex(), _messages.size(), _messages.size());
    _messages.append(message);
    endInsertRows();

    QModelIndex index = createIndex(0, 0, static_cast<void *>(0));
    emit dataChanged(index, index);
}
