import QtQml 2.2

QtObject {
    property string username: 'Имярек Батькович'
    property bool loggedIn: false
    property real coins: 101.1
    property int people: -1

    function requestCode(opts, callback) {
        callback({
            type: opts.type,
            value: opts.value,
            code: 'kocherga:' + opts.type + ':' + opts.value
        });
    }
    function destroyCode(code, callback) {
        callback();
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
        request('http://now.kocherga-club.ru/stat.json', function(stat) {
            if (stat) {
                people = stat.now;
            }
        })
    }

    Component.onCompleted: refreshPeople()
}
