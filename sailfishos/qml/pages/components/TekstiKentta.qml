import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    property int maxLength: -1
    Component.onCompleted: {
        console.debug("Tekstikentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: textField.text
    Column {
        width: parent.width
        Label {
            text: title
        }
        TextArea {
            id: textField
            placeholderText: placeHolderText()
            width: parent.width
            wrapMode: TextEdit.WordWrap
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
        if (maxLength > 0)
        {
            text += "Maksimipituus: " + maxLength + " merkkiä."
        }
        return text;
    }
}
