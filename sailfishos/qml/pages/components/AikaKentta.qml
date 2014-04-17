import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    property date dateTime: new Date()
    property bool acceptable: true
    Component.onCompleted: {
        console.debug("Aikakentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: Qt.formatDateTime(dateTime, "hh:mm:ss");
    ValueButton {
        id: button
        width: parent.width
        label: title
        valueColor: acceptable ? Theme.highlightColor : "#ff4d4d"
        value: Qt.formatDateTime(dateTime, "hh:mm:ss")

        onClicked: {
            var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog", { "hour": Qt.formatDateTime(dateTime, "h"), "minute": Qt.formatDateTime(dateTime, "m") })

            dialog.accepted.connect(function() {
                dateTime = dialog.time
                console.debug("validating..")
                acceptable = validate()
            })
        }
    }

    function validate()
    {
        console.debug("starting to validate date field")
        var curDateTime = new Date();
        if ((dateTime.getHours() * 60 + dateTime.getMinutes()) >
                (curDateTime.getHours() * 60 + curDateTime.getMinutes())) {
            console.debug("validation fails")
            return false;
        }
        console.debug("validation passes")
        return true;
    }
}
