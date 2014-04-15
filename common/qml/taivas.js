
function makeOffsetDate() {
    var d = new Date();
    d.setDate(d.getDate() - dateOffset)
    return d;
}

function havaitseTarkemmin() {
    detailedSearchRunning = true
    var xhr = new XMLHttpRequest
    var query = searchUrl + searchUser + detailedColumns + "&id=" + havainnot.get(havainto).id
    xhr.open("GET", query);
    xhr.onreadystatechange = function() {
        if (xhr.readyState == XMLHttpRequest.DONE) {
            detailedSearchRunning = false
            if (xhr.responseText.match("^No") != null)
                return
            var results = JSON.parse(xhr.responseText)
            if (results.observation[0].images) {
                var photos = results.observation[0].images.split(',')
                results.observation[0].photos = []
                for (var p in photos) {
                    results.observation[0].photos[p] = { "url" : photos[p] }
                }
            }
            havainnot.set(havainto, results.observation[0])
        } // TODO: handle errors
    }
    xhr.send();
}

function havaitse() {
    searchRunning = true
    var xhr = new XMLHttpRequest
    var query = searchUrl + searchUser + defaultColumns
    query += "&start=" + Qt.formatDate(startDate, "yyyy-MM-dd")
    query += "&end=" + Qt.formatDate(endDate, "yyyy-MM-dd")
    xhr.open("GET", query);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            havainnot.clear()
            viimeiset.clear()
            searchRunning = false
            if (xhr.responseText.match("^No") != null)
                return
            var results = JSON.parse(xhr.responseText)
            for (var i in results.observation) {
                if (results.observation[i].thumbnails) {
                    var thumbs = results.observation[i].thumbnails.split(',')
                    results.observation[i].thumbs = []
                    for (var p in thumbs) {
                        results.observation[i].thumbs[p] = { "url" : thumbs[p] }
                    }
                }
                havainnot.append(results.observation[i])
            }
            if (havainnot.count > 0)
                viimeiset.append({
                                     "category": havainnot.get(0).category,
                                     "start": havainnot.get(0).start
                                 })
            if (havainnot.count > 1)
                viimeiset.append({
                                     "category": havainnot.get(1).category,
                                     "start": havainnot.get(1).start
                                 })
        } // TODO: handle errors
    }
    xhr.send();
}

function kommentoi() {
    kommentit.clear()
    if (havainnot.get(havainto).comments && havainnot.get(havainto).comments === "0")
        return
    commentSearchRunning = true
    var xhr = new XMLHttpRequest;
    xhr.open("GET", commentUrl + "&observation=" + havainnot.get(havainto).id)
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            commentSearchRunning = false
            if (xhr.responseText.match("^No") != null)
                return
            var results = JSON.parse(xhr.responseText)
            for (var i in results.comment) {
                kommentit.append(results.comment[i])
            }
        } // TODO: handle errors
    }
    xhr.send();

}

function haeKategoriat() {
    var xhr = new XMLHttpRequest
    var query = categoriesUrl + categoryColumns
    xhr.open("GET", query);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            kategoriat.clear()
            if (xhr.responseText.match("^No") != null)
                return
            var results = JSON.parse(xhr.responseText)
            for (var i in results.category) {
                kategoriat.append(results.category[i])
            }
        } // TODO: handle errors
    }
    xhr.send();
}
