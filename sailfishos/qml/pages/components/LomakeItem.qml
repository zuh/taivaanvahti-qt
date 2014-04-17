import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
    property string fieldId: ""
    property string value: ""
    property bool mandatory: false
    property string title: ""
    width: parent.width
    height: childrenRect.height
    color: Theme.rgba(Theme.highlightBackgroundColor, 0.2)
}
