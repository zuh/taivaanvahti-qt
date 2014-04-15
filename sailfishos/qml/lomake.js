var item;
var component;
var mandatory = true;
function luoLomake(lomakeTeksti, vainPakolliset) {
    var lomakeItem = "import QtQuick 2.0; import Sailfish.Silica 1.0; ";
    lomakeItem += "Column { id: content; width: parent.width; ";
    mandatory = vainPakolliset;
    var teksti = JSON.parse(lomakeTeksti);
    var fields = teksti.observation.field;
    var specifics = teksti.category.specific;

    console.debug("Lomaketta luodaan..")
    for (var i in fields) {
        item = fields[i];
        luoKentta();
    }

    for (var i in specifics) {
        item = specifics[i];
        luoKentta();
    }

    return;
}

function luoKentta()
{
    if (mandatory && item.field_mandatory === "0")
    {
        return;
    }

    if (item.field_type === "text") {
        component = Qt.createComponent("pages/components/TekstiKentta.qml");
        if (odotaLatausta())
        {
            luoRajattuObjekti()
        }
    } else if (item.field_type === "numeric") {
        component = Qt.createComponent("pages/components/NumeroKentta.qml");
        if (odotaLatausta())
        {
            luoPerusObjekti()
        }
    } else if (item.field_type === "select") {
        component = Qt.createComponent("pages/components/SelectKentta.qml");
        if (odotaLatausta())
        {
            luoMonivalintaObjekti()
        }
    } else if (item.field_type === "time") {
        component = Qt.createComponent("pages/components/AikaKentta.qml");
        if (odotaLatausta())
        {
            luoPerusObjekti()
        }
    } else if (item.field_type === "date") {
        component = Qt.createComponent("pages/components/PaivamaaraKentta.qml");
        if (odotaLatausta())
        {
            luoPerusObjekti()
        }
    } else if (item.field_type === "coordinate") {
        component = Qt.createComponent("pages/components/KoordinaatitKentta.qml");
        if (odotaLatausta())
        {
            luoPerusObjekti()
        }
    }
}

function odotaLatausta()
{
    while (component.status !== Component.Ready)
    {
        if (component.status === Component.Error)
        {
            console.debug("Component got error: " + component.errorString())
            return false;
        }
        continue;
    }
    return true;
}

function luoRajattuObjekti()
{
    var maxLength = -1;
    if (item.hasOwnProperty('field_max_length')) {
        maxLength = item.field_max_length
    }
    component.createObject(col, {"fieldId": item.field_id,
                               "mandatory": (item.field_mandatory !== "0"),
                               "title": item.field_label,
                               "maxLength": maxLength})
}

function luoPerusObjekti()
{
    component.createObject(col, {"fieldId": item.field_id,
                               "mandatory": (item.field_mandatory !== "0"),
                               "title": item.field_label})
}

function luoMonivalintaObjekti()
{
    component.createObject(col, {"fieldId": item.field_id,
                               "mandatory": (item.field_mandatory !== "0"),
                               "title": item.field_label,
                               "values": item.values.value})
}
