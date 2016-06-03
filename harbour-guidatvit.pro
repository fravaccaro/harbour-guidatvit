# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-guidatvit
# Thanks, kimmoli! For future reference: https://github.com/kimmoli/test5-app/blob/master/test5.pro
TEMPLATE = aux

qml.files = qml/*

qml.path = /usr/share/harbour-guidatvit/qml

desktop.files = harbour-guidatvit.desktop
desktop.path = /usr/share/applications

appicons.path = /usr/share/icons/hicolor/
appicons.files = appicons/*

OTHER_FILES += \
    qml/* \
    qml/pages/* \
    qml/pages/storage.js \
    qml/pages/BookmarkPage.qml \
    qml/pages/devicePixelRatioHack.js \
    rpm/harbour-guidatvit.spec \
    translations/*.ts \
    translations/harbour-guidatvit.ts \
    translations/harbour-guidatvit-it.ts \
    harbour-guidatvit.desktop \
    harbour-guidatvit.png

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-guidatvit-it.ts

INSTALLS += appicons qml desktop

DISTFILES += \
    qml/cover/CoverPage.qml \
    html/style.css \
    html/canali.html \
    html/film.html \
    html/oraintv.html \
    html/primaserata.html \
    html/sport.html \
    qml/html/style.css \
    qml/html/film.html \
    qml/html/oraintv.html \
    qml/html/primaserata.html \
    qml/html/sport.html \
    qml/pages/HylePage.qml
