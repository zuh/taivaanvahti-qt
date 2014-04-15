import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    property var date: Qt.formatDateTime(new Date(), "yyyy-MM-dd")
    Component.onCompleted: {
        console.debug("Paivamaarakentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: Qt.formatDate(date, "yyyy-MM-dd")
    ValueButton {
        id: button
        width: parent.width
        label: title
        value: date

        onClicked: {
            var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", { date: new Date() })

            dialog.accepted.connect(function() {
                date = Qt.formatDate(dialog.date, "yyyy-MM-dd")
            })
        }
    }
}
