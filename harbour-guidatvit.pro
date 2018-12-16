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
    qml/harbour-guidatvit.qml \
    qml/pages/AboutPage.qml \
    qml/pages/BookmarkPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/IdlePage.qml \
    qml/components/BackgroundRectangle.qml \
    qml/components/BusyState.qml \
    qml/components/LabelText.qml \
    qml/components/dockedbar/DockedBar.qml \
    qml/cover/CoverPage.qml \
    qml/pages/devicePixelRatioHack.js \
    qml/pages/storage.js \
    qml/pages/appinfo.png \
    qml/cover/coverbg.png \
    rpm/harbour-guidatvit.spec \
    rpm/harbour-guidatvit.changes \
    harbour-guidatvit.desktop \
    harbour-guidatvit.png

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/*.ts

INSTALLS += appicons qml desktop

