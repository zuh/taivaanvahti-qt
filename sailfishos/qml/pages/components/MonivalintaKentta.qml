import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    property var values: ({})
    property bool acceptable: false
    id: itemi
    Component.onCompleted: {
        console.debug("Monivalintakentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: ""
    ValueButton {
        id: button
        width: parent.width
        label: title
        valueColor: acceptable ? Theme.highlightColor : "#ff4d4d"
        value: ""

        onClicked: {
            var dialog = pageStack.push("MonivalintaDialog.qml", { "values": values, "mandatory": mandatory, "value": itemi.value })

            dialog.accepted.connect(function() {
                itemi.value = dialog.value
                acceptable = dialog.acceptable
                button.value = dialog.getValueNames()
            })
        }
    }

    function validate()
    {
        return acceptable;
    }
}
