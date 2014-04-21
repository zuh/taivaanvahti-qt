import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property var values: ({})
    property bool acceptable: false
    property string value: ""
    property bool mandatory
    property string valueNames

    DialogHeader {
        id: header
        title: "Valitse yksi tai useampi"
        acceptText: "Hyväksy"
        cancelText: "Peruuta"
    }

    SilicaFlickable {
        id: flick
        width: parent.width
        anchors.top: header.bottom
        contentHeight: mainCol.height + 2 * Theme.PaddingLarge

        ScrollDecorator { flickable: flick }

        Column {
            id: mainCol
            spacing: Theme.paddingLarge
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            Column {
                id: itams
                width: parent.width
                spacing: Theme.paddingLarge
                Repeater {
                    model: values
                    TextSwitch {
                        property string valueId: modelData.value_id
                        text: modelData.value_name
                        Component.onCompleted: {
                            console.debug("id: " + valueId + " | value: " + text)
                        }
                        onCheckedChanged: {
                            updateValue();
                            acceptable = validate();
                        }
                    }
                }
            }
        }
    }

    function validate()
    {
        if (mandatory) {
            var isAnySelected = false;
            for (var i in col.children[i]) {
                if (col.children[i].checked) {
                    isAnySelected = true;
                    break;
                }
            }
            if (isAnySelected) {
                return true;
            } else {
                return false;
            }
        }
        return true;
    }

    function updateValue()
    {
        value = "";
        valueNames = "";
        var first = true;
        for (var i in itams.children)
        {
            console.debug("itams child")
            if (itams.children[i].checked)
            {
                console.debug("item checked")
                if (first)
                {
                    console.debug("first, not appending comma")
                    first = false;
                }
                else
                {
                    console.debug("not first, appending comma")
                    value += ",";
                    valueNames += ", "
                }
                console.debug("appending with value " + itams.children[i].valueId)
                value += itams.children[i].valueId;
                valueNames += itams.children[i].text;
            }
            else
            {
                console.debug("child " + itams.children[i].valueId + " not checked")
            }
        }
        console.debug("updated value to; " + value);
        console.debug("value names: " + valueNames)
    }
}
