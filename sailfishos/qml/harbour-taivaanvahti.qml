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
import "pages"
import "taivas.js" as TaivasScript

ApplicationWindow
{
    id: taivas
    initialPage: Qt.createComponent("pages/Havainnot.qml")
    cover: Qt.createComponent("cover/CoverPage.qml")

    property int havainto: 0
    property var havainnot: ListModel {}
    property var kommentit: ListModel {}
    property var viimeiset: ListModel {}
    property var kategoriat: ListModel {}

    property bool searchRunning: false
    property bool detailedSearchRunning: false
    property bool commentSearchRunning: false
    property string searchUser: ""
    property string searchUrl: "http://www.ursa.fi/~obsbase/search_3.php?format=json"
    property string categoriesUrl: "http://www.ursa.fi/~obsbase/categories.php?format=json"
    property string defaultColumns: "&columns=id,title,start,city,category,thumbnails,comments"
    property string detailedColumns: "&columns=user,team,description,details,link,equipment,images"
    property string categoryColumns: "&columns=id,title"
    property string commentUrl: "http://www.ursa.fi/~obsbase/comment_search.php?format=json&order=asc"
    property int dateOffset: 5
    property var startDate: TaivasScript.makeOffsetDate()
    property var endDate: new Date()
    property string searchObserver: ""
    property string searchTitle: ""
    property var searchCategories: {
        "all": true,
        "tahtikuva": false,
        "komeetta": false,
        "pimennys": false,
        "tulipallo": false,
        "revontuli": false,
        "yopilvi": false,
        "myrsky": false,
        "halo": false,
        "muu": false
    }

    function havaitseTarkemmin() {
        TaivasScript.havaitseTarkemmin()
    }

    function havaitse() {
        TaivasScript.havaitse()
    }

    function kommentoi() {
        TaivasScript.kommentoi()
    }

    function haeKategoriat() {
        TaivasScript.haeKategoriat()
    }
}
