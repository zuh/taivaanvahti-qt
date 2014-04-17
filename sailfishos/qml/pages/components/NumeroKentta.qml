import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    Component.onCompleted: {
        console.debug("Numerokentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: numField.text
    Column {
        width: parent.width
        Item {
            width: parent.width
            height: numLabel.height + 2 * Theme.paddingLarge
            Label {
                id: numLabel
                text: title

            }
        }
        TextField {
            id: numField
            placeholderText: placeHolderText()
            width: parent.width
            inputMethodHints: Qt.ImhDigitsOnly
        }
    }

    function placeHolderText()
    {
        var text = "";
        if (mandatory) {
            text += "Pakollinen. ";
        } else {
            text += "Vapaaehtoinen. ";
        }
        return text;
    }

    function validate()
    {
        console.debug("starting to validate numeric field")
        if (mandatory && numField.text.length <= 0) {
            console.debug("validation fails")
            return false;
        }
        console.debug("validation passes")
        return true;
    }
}
