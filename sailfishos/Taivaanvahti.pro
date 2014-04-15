# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-taivaanvahti

CONFIG += sailfishapp

SOURCES += \
    src/Taivaanvahti.cpp \
    ../common/src/lomakemanager.cpp

SCRIPTS = \
    ../common/qml/taivas.js \
    qml/lomake.js

OTHER_FILES += qml/harbour-taivaanvahti.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-taivaanvahti.spec \
    rpm/harbour-taivaanvahti.yaml \
    harbour-taivaanvahti.desktop \
    qml/pages/Tietoja.qml \
    qml/pages/Photos.qml \
    qml/pages/Havainto.qml \
    qml/pages/Havainnot.qml \
    qml/pages/Haku.qml \
    qml/pages/Raportoi.qml \
    qml/pages/Lomake.qml \
    qml/pages/components/LomakeItem.qml \
    qml/pages/components/TekstiKentta.qml \
    qml/pages/components/NumeroKentta.qml \
    qml/pages/components/SelectKentta.qml \
    qml/pages/components/AikaKentta.qml \
    qml/pages/components/PaivamaaraKentta.qml \
    qml/pages/components/KoordinaatitKentta.qml

HEADERS += \
    ../common/src/lomakemanager.h

scripts.files += $${SCRIPTS}
scripts.path += /usr/share/$${TARGET}/qml/

INSTALLS += scripts
