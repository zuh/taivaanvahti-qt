#include "lomakemanager.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QDebug>

LomakeManager::LomakeManager(QObject *parent) :
    QObject(parent)
{
}

void LomakeManager::haeLomake(const int& id)
{
    QNetworkRequest request;
    request.setUrl(QUrl("https://www.taivaanvahti.fi/api"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QString requestString = QString("{\"request\": {\"Action\":\"FormTemplateRequest\",\"Category\":\"%1\"}}").arg(id);

    QNetworkReply *reply = mNam.post(request, requestString.toUtf8());
    connect(reply, &QNetworkReply::finished, this, &LomakeManager::lomakeVastaanotettu);
}

void LomakeManager::asetaKategoria(QString name)
{
    mKategoriaTitle = name;
}

void LomakeManager::lisaaPari(QString id, QString value)
{
    if (!id.isEmpty() && !value.isEmpty())
    {
        mMap.insert(id, value);
    }
}

void LomakeManager::lahetaLomake()
{
    for(QMap<QString, QString>::iterator iter = mMap.begin(); iter != mMap.end(); ++iter)
    {
        qDebug() << iter.key() << iter.value();
    }

    QNetworkRequest request;
    request.setUrl(QUrl("https://www.taivaanvahti.fi:8443/api"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QString outString = "{ \"request\" : { \"action\":\"ObservationAddRequest\", \"observation\":[ ";

    for (QMap<QString, QString>::iterator iter = mMap.begin(); iter != mMap.end(); ++iter)
    {
        outString.append("{ \"field\":{ ");
        outString.append("\"field_id\":\"").append(iter.key()).append("\",");
        outString.append("\"field_value\":\"").append(iter.value()).append("\" } } ,");
    }
    outString.append("{ \"category\":{ \"field\":{");
    outString.append("\"field_id\":\"category_id\",");
    outString.append("\"field_value\":\"").append(mKategoriaTitle).append("\" } } } ],");
    outString.append("\"source\":\"Taivaanvahti-Jolla\" } }");
    qDebug() << outString;
    QNetworkReply *reply = mNam.post(request, outString.toUtf8());
    connect(reply, SIGNAL(finished()), this, SLOT(lomakeLahetetty()));
}

void LomakeManager::lomakeVastaanotettu()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    QString replyString = QString::fromUtf8(reply->readAll());
    qDebug() << replyString;
    emit lomakeSaatavilla(replyString);
}

void LomakeManager::lomakeLahetetty()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    QString replyString = QString::fromUtf8(reply->readAll());
    qDebug() << replyString;
    emit lomakeDone();
}
