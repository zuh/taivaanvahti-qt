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
    property alias currentIndex: ss.currentIndex

    allowedOrientations: Orientation.All

    PageHeader {
        id: header
        title: "Sovitettu koko"
        z: 1
    }

    SlideshowView {

        id: ss

        anchors.fill: parent

        model: taivas.havainnot.get(taivas.havainto).photos

        delegate: Image {
            id: photo
            width: ss.width
            height: ss.height
            asynchronous: true
            cache: true
            fillMode: Image.PreserveAspectFit
            source: url
            smooth: false
            property bool scaled: true

            onStatusChanged: {
                if (status != Image.Ready)
                    return
                busy.running = false
                initialSize()
            }

            onScaledChanged: {
                if (scaled)
                     header.title = "Sovitettu koko"
                else
                     header.title = "Alkuperäinen koko"
            }

            function initialSize() {
                if (width >= sourceSize.width && height >= sourceSize.height) {
                    width = sourceSize.width
                    height = sourceSize.height
                    scaled = false
                    panner.enabled = false
                }

                if (width > ss.width || height > ss.height) {
                    width = ss.width
                    height = ss.height
                    scaled = true
                }
            }

            function toggleSize() {
                if (width > ss.width || height > ss.height) {
                    width = ss.width
                    height = ss.height
                    scaled = true
                } else {
                    width = sourceSize.width
                    height = sourceSize.height
                    scaled = false
                }
            }

            BusyIndicator {
                id: busy
                width: Theme.itemSizeLarge
                height: Theme.itemSizeLarge
                anchors.centerIn: parent
                visible: running
                running: true
            }

            MouseArea {
                id: panner
                anchors.fill: parent
                enabled: true
                onClicked: {
                    photo.toggleSize()
                    if (photo.scaled)
                        drag.target = null
                    else
                        drag.target = photo
                }
            }

        }

        function resetSize() {
            currentItem.initialSize()
        }
    }

    Label {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: Theme.paddingLarge
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

    onStatusChanged: {
        if (status === PageStatus.Deactivating)
            ss.resetSize()
    }
}
