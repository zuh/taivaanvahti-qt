import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    property var values: ({})
    property bool acceptable: false
    property string value: ""
    property bool mandatory
    property var selected: ({})
    property bool dataInitialized: false

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
                            dataInitialized = false;
                            selected = value.split(",");
                            if (selected.indexOf(valueId) != -1)
                            {
                                checked = true;
                            }
                            console.debug("id: " + valueId + " | value: " + text + " | selected: " + checked)
                            dataInitialized = true;
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
        if (!dataInitialized)
        {
            return;
        }
        value = "";
        var first = true;
        for (var i in itams.children)
        {
            if (itams.children[i].checked)
            {
                if (first)
                {
                    first = false;
                }
                else
                {
                    value += ",";
                }
                value += itams.children[i].valueId;
            }
        }
        console.debug("updated value to; " + value);
    }

    function getValueNames()
    {
        var valueNames = "";
        var first = true;
        for (var i in itams.children)
        {
            if (itams.children[i].checked)
            {
                if (first)
                {
                    first = false;
                }
                else
                {
                    valueNames += ", "
                }
                valueNames += itams.children[i].text;
            }
        }
        console.debug("value names: " + valueNames)
        return valueNames;
    }
}
