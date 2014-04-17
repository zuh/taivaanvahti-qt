import QtQuick 2.0
import Sailfish.Silica 1.0

LomakeItem {
    id: mainItem
    property var values: ({})
    Component.onCompleted: {
        console.debug("Selectkentta: " + title + " | " + mandatory + " | " + fieldId);
    }
    value: box.currentItem.valueId
    ComboBox {
        id: box
        width: parent.width
        label: title
        menu: ContextMenu {
            id: menu
            Repeater {
                model: values
                MenuItem {
                    property string valueId: modelData.value_id
                    text: modelData.value_name
                    Component.onCompleted: {
                        console.debug("id: " + valueId + " | value: " + text)
                    }
                }
            }
        }
        onCurrentIndexChanged: {
            mainItem.value = box.currentItem.valueId
        }
    }

    function validate()
    {
        console.debug("starting to validate select field")
        if (mandatory && value === "- valitse -") {
            console.debug("validation fails")
            return false;
        }
        console.debug("validation passes")
        return true;
    }
}
