import QtQml 2.2
import QtQuick 2.0
import QZXing 2.3

QtObject {
    property url statLink: 'http://now.kocherga-club.ru/stat.json'
    property url pagesLink: 'http://now.kocherga-club.ru/static/mobile-pages.json'
    property string username: 'Имярек Батькович'
    property bool loggedIn: false
    property real coins: 101.1
    property int people: -1
    property var webviews: []

    property ListModel pages: ListModel {}

    function coinsAdd(value) {
        coins = Math.round((coins + value) * 1e9) / 1e9;
    }

    signal codeDestroyed(string code)

    function codeConsume(code) {
        codeInfo(code, function(info) {
            if (info.type === 'coins') {
                coinsAdd(-info.value);
            }
            codeDestroyed(code);
        });
    }

    function codeDestroy(code) {
        if (!code) return;
        codeDestroyed(code);
    }

    function codeInfo(code, callback) {
        var parts = code.split(':');
        if (parts.length !== 3) return;
        if (parts[0] !== 'kocherga') return;
        if (parts[1] === 'coins') {
            parts[2] = parseFloat(parts[2], 10);
        }
        callback({ type: parts[1], value: parts[2] });
    }

    function codeCreate(opts, callback) {
        callback({
            type: opts.type,
            value: opts.value,
            code: 'kocherga:' + opts.type + ':' + opts.value
        });
    }

    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState !== XMLHttpRequest.DONE) {
                return;
            }
            if (xhr.status && xhr.status === 200) {
                var result = JSON.parse(xhr.responseText)
                if (result) {
                    callback(result);
                } else {
                    callback(null);
                }
                //callback(xhr.responseText);
            } else {
                callback(null);
            }
        };
        xhr.open('GET', url, true);
        xhr.send('');
    }

    function refreshPeople() {
        request(statLink, function(stat) {
            if (!stat) return;
            people = stat.now;
        })
    }

    function refreshPages() {
        request(pagesLink, function(data) {
            if (!data) return; // TODO: try to refresh on timeout
            webviews.length = 0;
            pages.clear();
            for (var i in data) {
                var r = data[i];
                if (r.hasOwnProperty('enabled') && !r.enabled) continue;
                pages.append({
                    name: r.name,
                    url: r.url,
                    external: r.external || false
                });
            }
        })
    }

    Component.onCompleted: {
        refreshPeople();
        refreshPages();
    }

    /* QR stuff */

    signal decodingStarted()
    signal decodingFinished(bool succeeded)
    signal tagFound(string tag)
    property var zxingFilter: QZXingFilter {
        onDecodingStarted: api.decodingStarted()
        onDecodingFinished: api.decodingFinished(succeeded)
        onTagFound: api.tagFound(tag)
    }
}
