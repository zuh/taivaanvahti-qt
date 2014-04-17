import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    property date date: new Date()
    property bool acceptable: true
    Component.onCompleted: {
        console.debug("Paivamaarakentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: Qt.formatDate(date, "yyyy-MM-dd")
    ValueButton {
        id: button
        width: parent.width
        label: title
        value: Qt.formatDate(date, "d. MMMM yyyy")
        valueColor: acceptable ? Theme.highlightColor : "#ff4d4d"
        onClicked: {
            var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", { "date": new Date()})

            dialog.accepted.connect(function() {
                date = dialog.date
                acceptable = validate()
            })
        }
    }

    function validate()
    {
        console.debug("starting to validate date field")
        var curDate = new Date()
        if (date.getFullYear() > curDate.getFullYear()) {
            console.debug("validation fails")
            return false;
        } else if (date.getMonth() > curDate.getMonth()) {
            console.debug("validation fails")
            return false;
        } else if (date.getDate() > curDate.getDate()) {
            console.debug("validation fails")
            return false;
        }
        console.debug("validation passes")
        return true;
    }
}
