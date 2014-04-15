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
    property bool dialogRunning: false

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: header.height + col.height + Theme.paddingLarge

        ScrollDecorator { flickable: flick }

        PageHeader {
            id: header
            title: "Hakuehdot"
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

            Button {
                anchors.horizontalCenter: parent.Center
                text: "Palauta oletushaku"
                onClicked: {
                    taivas.searchUser = ""
                    observer.text = ""
                    title.text = ""
                    all.checked = true
                    end.date = new Date()
                    start.date = taivas.makeOffsetDate()
                }
            }

            Column {
                id: dates
                width: parent.width

                Label {
                    anchors.right: parent.right
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.highlightColor
                    font.family: Theme.fontFamilyHeading
                    text: "Aikajakso"
                }

                ValueButton {
                    id: start
                    width: col.width
                    label: "Alku"
                    value: Qt.formatDate(date, "yyyy-MM-dd")
                    property var date: taivas.startDate

                    onClicked: {
                        page.dialogRunning = true
                        var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", { date: date })

                        dialog.accepted.connect(function() {
                            page.dialogRunning = false
                            if (dialog.date < end.date)
                                taivas.startDate = dialog.date
                        })
                    }
                }

                ValueButton {
                    id: end
                    width: parent.width
                    label: "Loppu"
                    value: Qt.formatDate(date, "yyyy-MM-dd")
                    property var date: taivas.endDate

                    onClicked: {
                        page.dialogRunning = true
                        var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", { date: date })

                        dialog.accepted.connect(function() {
                            page.dialogRunning = false
                            if (dialog.date > start.date)
                                taivas.endDate = dialog.date
                        })
                    }
                }
            }



            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Kategoria"
            }

            Column {
                id: category
                width: parent.width

                TextSwitch {
                    id: all
                    checked: true
                    property string category: "all"
                    text: "Kaikki"
                    description: "Kaikki taivaan ilmiöt"
                }

                TextSwitch {
                    id: tahtikuva
                    enabled: !all.checked
                    property string category: "tahtikuva"
                    text: "Tähdet ja aurinkokunta"
                    description: "Avaruuden kappaleet"
                }

                TextSwitch {
                    id: komeetta
                    enabled: !all.checked
                    property string category: "komeetta"
                    text: "Komeetta"
                    description: "Toiselta nimeltään pyrstötähti"
                }

                TextSwitch {
                    id: pimennys
                    enabled: !all.checked
                    property string category: "pimennys"
                    text: "Pimennys"
                    description: "Kuun tai auringon pimennykset"
                }

                TextSwitch {
                    id: tulipallo
                    enabled: !all.checked
                    property string category: "tulipallo"
                    text: "Tulipallo"
                    description: "Harvinaisen kirkkaat tähdenlennot"
                }

                TextSwitch {
                    id: revontuli
                    enabled: !all.checked
                    property string category: "revontuli"
                    text: "Revontulet"
                    description: "Aurinkotuulen hiukkaset ilmakehässä"
                }

                TextSwitch {
                    id: yopilvi
                    enabled: !all.checked
                    property string category: "yopilvi"
                    text: "Valaisevat yöpilvet"
                    description: "Pilvet avaruuden rajalla"
                }

                TextSwitch {
                    id: myrsky
                    enabled: !all.checked
                    property string category: "myrsky"
                    text: "Myrskyilmiö"
                    description: "Erityiset myrskyn ilmiöt"
                }

                TextSwitch {
                    id: halo
                    enabled: !all.checked
                    property string category: "halo"
                    text: "Haloilmiö"
                    description: "Kirkkaan valonlähteen heijastumat"
                }

                TextSwitch {
                    id: muu
                    enabled: !all.checked
                    property string category: "muu"
                    text: "Muu ilmiö"
                    description: "Muut valoilmiöt"
                }

            }

            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Havainnon tekijä"
            }

            TextField {
                id: observer
                width: parent.width
                focus: false
                placeholderText: "Kuka Tahansa"
            }

            Label {
                anchors.right: parent.right
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.family: Theme.fontFamilyHeading
                text: "Havainnon otsikko"
            }

            TextField {
                id: title
                width: parent.width
                focus: false
                placeholderText: "Mikä vain"
            }

        }
    }

    Component.onCompleted: {
        for (var i = 0; i < category.children.length; i++) {
            var child = category.children[i]
            child.checked = taivas.searchCategories[child.category]
        }

        observer.text = taivas.searchObserver
        title.text = taivas.searchTitle
    }

    onStatusChanged: {
        if (status !== PageStatus.Deactivating)
            return;

        if (page.dialogRunning)
            return;

        taivas.searchUser = ""
        taivas.searchCategories["all"] = all.checked
        if (!all.checked) {
            for (var i = 1; i < category.children.length; i++) {
                var child = category.children[i]
                taivas.searchCategories[child.category] = child.checked
                if (child.checked)
                    taivas.searchUser += "&category=" + child.category
            }
        }

        if (observer.text)
            taivas.searchUser += "&user=" + encodeURIComponent(observer.text)
        if (title.text)
            taivas.searchUser += "&title=" + encodeURIComponent(title.text)

        taivas.searchObserver = observer.text
        taivas.searchTitle = title.text
//        taivas.startDate = start.date
//        taivas.endDate = end.date

        taivas.havaitse()

    }
}
