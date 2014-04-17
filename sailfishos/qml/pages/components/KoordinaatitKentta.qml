import QtQuick 2.0
import Sailfish.Silica 1.0
import QtPositioning 5.0

LomakeItem {
    property real lat: 0.0
    property real lon: 0.0
    value: lat + ", " + lon
    height: coord.height + 2 * Theme.paddingLarge
    Component.onCompleted: {
        console.debug("Koordinaatitkentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    Item {
        width: parent.width
        height: coord.height + 2 * Theme.paddingLarge
        Label {
            id: coord
            width: parent.width - 2 * Theme.paddingLarge
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.top: parent.top
            anchors.topMargin: Theme.paddingLarge
            text: title + ": " + lat + ", " + lon
            elide: Text.ElideRight
        }
    }
    PositionSource {
        id: positionSource
        updateInterval: 1000
        onPositionChanged: {
            lat = position.coordinate.latitude
            lon = position.coordinate.longitude
        }
    }

    function validate()
    {
        console.debug("starting to validate coordinate field")
        if (value === ", ") {
            console.debug("validation fails")
            return false;
        }
        console.debug("validation passes")
        return true;
    }
}
