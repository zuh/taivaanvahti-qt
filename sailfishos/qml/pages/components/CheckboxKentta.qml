import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    Component.onCompleted: {
        console.debug("Checkboxkentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: ""
    Item {
        width: parent.width
        height: button.height + 1.5 * Theme.paddingLarge
        TextSwitch {
            id: button
            text: title
            anchors.top: parent.top
            anchors.topMargin: 0.5 * Theme.paddingLarge
            onCheckedChanged:
            {
                if (checked)
                {
                    value = fieldId
                }
                else
                {
                    value = ""
                }
            }
        }
    }

    function validate()
    {
        return true;
    }
}
