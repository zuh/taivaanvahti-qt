import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    property int maxLength: -1
    property int charsLeft: (maxLength - textField.text.length)
    Component.onCompleted: {
        console.debug("Tekstikentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: textField.text
    Column {
        width: parent.width
        Item {
            width: parent.width
            height: indentedText.height + 2 * Theme.paddingLarge
            Label {
                id: indentedText
                width: parent.width - (2 * Theme.paddingLarge)
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.top: parent.top
                anchors.topMargin: Theme.paddingLarge
                text: title
            }
        }
        TextArea {
            id: textField
            placeholderText: placeHolderText()
            width: parent.width
            wrapMode: TextEdit.WordWrap
        }
        Item {
            width: parent.width
            height: charsLeftLabel.height + 2 * Theme.paddingLarge
            Label {
                id: charsLeftLabel
                width: parent.width - 2 * Theme.paddingLarge
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.top: parent.top
                anchors.topMargin: Theme.paddingLarge
                visible: (maxLength > 0)
                text: charsLeft + ((charsLeft == 1) ? " merkki jäljellä." : " merkkiä jäljellä.")
                color: (charsLeft < 0) ? "#ff4d4d" : Theme.secondaryColor
            }
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
        if (maxLength > 0) {
            text += "Maksimipituus: " + maxLength + " merkkiä."
        }
        return text;
    }

    function validate()
    {
        console.debug("starting to validate text fieldd")
        if (!mandatory && (maxLength > 0) && charsLeft < 0) {
            console.debug("validation fails")
            return false;
        } else if (mandatory && ((maxLength > 0 && charsLeft < 0) || textField.text.length === 0)) {
            console.debug("validation fails")
            return false;
        }
        console.debug("validation passes")
        return true;
    }
}
