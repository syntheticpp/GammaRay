/*
  messagemodel.h

  This file is part of GammaRay, the Qt application inspection and
  manipulation tool.

  Copyright (C) 2010-2011 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com
  Author: Milian Wolff <milian.wolff@kdab.com>

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
#ifndef MESSAGEMODEL_H
#define MESSAGEMODEL_H

#include <QtCore/QAbstractTableModel>

namespace GammaRay {

class MessageModel : public QAbstractTableModel {
  Q_OBJECT
  public:
    explicit MessageModel(QObject *parent = 0);
    virtual ~MessageModel();

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual QVariant headerData(int section, Qt::Orientation orientation,
                                int role = Qt::DisplayRole) const;

    enum Columns {
      TypeColumn,
      MessageColumn,
      COLUMN_COUNT
    };

    typedef QPair<QtMsgType, QString> Message;

  public slots:
    void addMessage(const MessageModel::Message &message);

  private:
    QList<Message> m_messages;
};

}

#endif // MESSAGEMODEL_H
