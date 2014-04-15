#ifndef LOMAKEMANAGER_H
#define LOMAKEMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QMap>

class LomakeManager : public QObject
{
    Q_OBJECT
public:
    explicit LomakeManager(QObject *parent = 0);
    Q_INVOKABLE void haeLomake(const int& id);
    Q_INVOKABLE void asetaKategoria(QString name);
    Q_INVOKABLE void lisaaPari(QString id, QString value);
    Q_INVOKABLE void lahetaLomake();
signals:
    Q_INVOKABLE void lomakeSaatavilla(const QString& replyString);
    Q_INVOKABLE void lomakeDone();
public slots:
    void lomakeVastaanotettu();
    void lomakeLahetetty();

private:
    QNetworkAccessManager mNam;
    QMap<QString, QString> mMap;
    QString mKategoriaTitle;
};

#endif // LOMAKEMANAGER_H
