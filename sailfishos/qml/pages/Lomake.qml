import QtQuick 2.0
import Sailfish.Silica 1.0
import "components"
import "../lomake.js" as LomakeScript

Page {
    id: lomakePage
    property string categoryName: ""
    property alias category: header.title
    property string lomakeText: ""
    property bool vainPakolliset: true
    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: header.height + col.height + 2 * Theme.PaddingLarge + sendButton.height

        Component.onCompleted: {
            LomakeScript.luoLomake(lomakeText, vainPakolliset);
            lomakemanager.lomakeDone.connect(lomakeValmis)
        }

        ScrollDecorator { flickable: flick }

        PageHeader {
            id: header
        }
        Column {
            id: mainCol
            spacing: Theme.paddingLarge
            anchors.top: header.bottom
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingLarge
            Column {
                id: col
                width: parent.width
            }
            Button {
                id: sendButton
                width: parent.width
                text: "Lähetä"
                onClicked: {
                    for (var i in col.children)
                    {
                        lomakemanager.lisaaPari(col.children[i].fieldId, col.children[i].value)
                    }
                    lahetysLabel.text = "Lomaketta lähetetään.."
                    lomakemanager.asetaKategoria(categoryName)
                    lomakemanager.lahetaLomake();
                }
            }
            Label {
                id: lahetysLabel
                text: ""
            }
        }
    }
    function lomakeValmis()
    {
        lahetysLabel.text = "Lomake lähetetty!"
    }
}
