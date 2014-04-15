/*
  Copyright (C) 2013 Kalle Vahlman, <zuh@iki.fi>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    property var photoComp: null
    property var photoPage: null

    SilicaFlickable {
        id: flick
        anchors.fill: parent

        contentHeight: header.height + col.height + Theme.paddingLarge

        ScrollDecorator { flickable: flick }

        PageHeader {
            id: header
            title: {
                if (busy.running)
                    return ""
                return taivas.havainnot.get(taivas.havainto).start || ""
            }

            BusyIndicator {
                id: busy
                anchors.centerIn: parent
                visible: running
                running: taivas.detailedSearchRunning
            }
        }

        Column {
            id: col
            spacing: Theme.paddingLarge
            anchors.top: header.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge

            Column {
                id: topcol
                width: parent.width

                Label {
                    width: parent.width
                    elide: Text.ElideRight
                    text: taivas.havainnot.get(taivas.havainto).title || ""
                }

                Label {
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryColor
                    text: taivas.havainnot.get(taivas.havainto).user || ""
                }

                Label {
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryColor
                    text: taivas.havainnot.get(taivas.havainto).team || ""
                }

                Label {
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryColor
                    text: taivas.havainnot.get(taivas.havainto).city || ""
                }
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 1024
                text: taivas.havainnot.get(taivas.havainto).description || ""
            }


            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: {
                    if (taivas.havainnot.get(taivas.havainto).details != "")
                        return "Lisätiedot"
                    else
                        return ""
                }
            }

            Column {
                width: parent.width
                spacing: Theme.paddingSmall

                Repeater {
                    model: {
                        if (taivas.havainnot.get(taivas.havainto).details)
                            return taivas.havainnot.get(taivas.havainto).details.split(',')
                        return null
                    }

                    delegate: Label {
                        font.pixelSize: Theme.fontSizeTiny
                        text: {
                            if (modelData.search("http") >= 0)
                                return ""
                            return modelData
                        }
                    }
                }
            }

            Row {
                layoutDirection: Qt.RightToLeft
                width: parent.width
                spacing: Theme.paddingLarge

                Column {
                    id: photoHeader
                    spacing: Theme.paddingSmall

                    Label {
                        width: parent.width
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        font.family: Theme.fontFamilyHeading
                        horizontalAlignment: Text.AlignRight
                        text: {
                            if (taivas.havainnot.get(taivas.havainto).thumbs && taivas.havainnot.get(taivas.havainto).thumbs.count)
                                return "Kuvat (" + taivas.havainnot.get(taivas.havainto).thumbs.count + ")"
                            else
                                return ""
                        }
                    }
                    Label {
                        font.pixelSize: Theme.fontSizeTiny
                        color: Theme.highlightColor
                        font.family: Theme.fontFamilyHeading
                        text: {
                            if (taivas.havainnot.get(taivas.havainto).thumbs && taivas.havainnot.get(taivas.havainto).thumbs.count)
                                return "© 2013 " + taivas.havainnot.get(taivas.havainto).user
                            else
                                return ""
                        }
                    }
                }

            }

            Flow {
                id: photos
                width: parent.width
                spacing: Theme.paddingSmall
                property int loaded: 0

                Repeater {
                    id: photoRepeater
                    model: taivas.havainnot.get(taivas.havainto).thumbs
                    onModelChanged: {
                        if (model.count > 0 && model.count != photos.loaded)
                            busyTail.running = true
                    }

                    delegate: BackgroundItem {
                        width: photo.width
                        height: photo.height
                        Image {
                            id: photo
                            asynchronous: true
                            cache: true
                            fillMode: Image.PreserveAspectFit
                            source: modelData
                            onProgressChanged: {
                                if (progress == 1.0)
                                    photos.loaded++
                                if (photos.loaded >= photoRepeater.model.count)
                                    busyTail.running = false
                            }
                        }

                        onClicked: {
                            if (page.photoPage === null)
                                page.photoPage = Qt.createComponent("Photos.qml").createObject(page)
                            page.photoPage.currentIndex = index
                            pageStack.push(page.photoPage)
                        }
                    }
                }

                BusyIndicator {
                    id: busyTail
                    visible: running
                    running: false
                }

            }

            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: {
                    if (taivas.havainnot.get(taivas.havainto).equipment != "")
                        return "Tekniset tiedot"
                    else
                        return ""
                }
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                maximumLineCount: 1024
                text: taivas.havainnot.get(taivas.havainto).equipment || ""
            }

            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: {
                    if (taivas.kommentit && taivas.kommentit.count > 0)
                        return "Kommentit (" + taivas.kommentit.count + ")"
                    else
                        return ""
                }
            }

            Column {
                id: comments
                spacing: Theme.paddingLarge

                Repeater {
                    model: taivas.kommentit
                    delegate: Column {
                        Label {
                            font.pixelSize: Theme.fontSizeSmall
                            text: user
                        }
                        Label {
                            font.pixelSize: Theme.fontSizeTiny
                            color: Theme.secondaryColor
                            text: start
                        }
                        Label {
                            width: col.width
                            wrapMode: Text.WordWrap
                            maximumLineCount: 1024
                            text: model.text
                        }
                    }
                }

                BusyIndicator {
                    id: busyComments
                    anchors.left: parent.left
                    anchors.leftMargin: (parent.width - width) / 2
                    visible: running
                    running: taivas.commentSearchRunning
                }

            }

            Column {
                width: parent.width
                spacing: Theme.paddingSmall

                Label {
                    anchors.right: parent.right
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                    horizontalAlignment: Text.AlignRight
                    text: "Havainto taivaanvahdissa"
                }

                BackgroundItem {
                    height: Theme.itemSizeSmall

                    Label {
                        anchors.centerIn: parent
                        font.pixelSize: Theme.fontSizeTiny
                        text: taivas.havainnot.get(taivas.havainto).link || ""
                    }

                    onClicked: Qt.openUrlExternally(taivas.havainnot.get(taivas.havainto).link)
                }
            }
        }

    }

}
