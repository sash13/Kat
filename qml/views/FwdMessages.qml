/*
  Copyright (C) 2016 Petr Vytovtov
  Contact: Petr Vytovtov <osanwe@protonmail.ch>
  All rights reserved.

  This file is part of Kat.

  Kat is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  Kat is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Kat.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Column {
    id: fwdColumn

    width: maximumWidth
    height: childrenRect.height

    Repeater {
        id: messagesRepeater
        model: messages

        Row {
            width: fwdColumn.width
            height: childrenRect.height
            spacing: Theme.paddingSmall
            LayoutMirroring.enabled: out

            Rectangle {
                width: 1
                height: message.height
                color: read ? Theme.primaryColor : Theme.highlightColor
            }

            Column {
                id: message
                width: parent.width - Theme.paddingSmall - 1
                height: childrenRect.height
                spacing: Theme.paddingSmall

                Label {
                    id: datetime
                    width: parent.width
                    horizontalAlignment: Text.AlignLeft
                    color: messageItem.highlighted || (!read && out) ? Theme.secondaryHighlightColor: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeTiny
                    LayoutMirroring.enabled: out
                    text: convertUnixtimeToString(messagesRepeater.model.get(index).date)
                    visible: text !== ""
                }

                Label {
                    id: body
                    width: parent.width
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.Wrap
                    color: messageItem.highlighted || (!read && out) ? Theme.highlightColor : Theme.primaryColor
                    linkColor: messageItem.highlighted ? Theme.primaryColor : Theme.highlightColor
                    LayoutMirroring.enabled: out
                    visible: text !== ""
                    text: messagesRepeater.model.get(index).body

                    onLinkActivated: Qt.openUrlExternally(link)
                }

                AttachmentsView {
                    width: parent.width
                    aout: isOut
                    aread: read
                    amessages: messagesRepeater.model.get(index).fwdMessages
                }
            }
        }
    }
}

