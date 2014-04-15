import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    id: masterItem
    Component.onCompleted: {
        console.debug("Aikakentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: Qt.formatDateTime(new Date(), "hh:mm:ss");
    ValueButton {
        id: button
        width: parent.width
        label: title
        value: Qt.formatDateTime(new Date(), "hh:mm:ss")

        onClicked: {
            var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog")

            dialog.accepted.connect(function() {
                console.debug("timepicker time: " + dialog.time)
                button.value = Qt.formatTime(dialog.time, "hh:mm:ss")
                masterItem.value = Qt.formatTime(dialog.time, "hh:mm:ss")
            })
        }
    }
}
