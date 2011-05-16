VERSION = 0.2.7
PROJECT_NAME = meego-app-contacts

TEMPLATE = lib
TARGET = Contacts
QT += declarative \
    dbus
CONFIG += qt \
        plugin \
        dbus \
        mobility \
        link_pkconfig

#PKGCONFIG += telepathy-qml-lib
PKGCONFIG += QtContacts QtVersit icu-uc icu-i18n

TARGET = $$qtLibraryTarget($$TARGET)
DESTDIR = $$TARGET
OBJECTS_DIR = .obj
MOC_DIR = .moc
LIBS += -licuuc -licui18n

MOBILITY = contacts versit

HEADERS += \
    contacts.h \
    peoplemodel.h \
    peoplemodel_p.h \
    proxymodel.h \
    settingsdatastore.h \
    localeutils.h

SOURCES += \
    contacts.cpp \
    peoplemodel.cpp \
    proxymodel.cpp \
    settingsdatastore.cpp \
    localeutils.cpp

QML_FILES = *.qml

OTHER_FILES += $${QML_FILES} Contacts/qmldir

qmlfiles.files += $${QML_FILES}
qmlfiles.path += $$INSTALL_ROOT/usr/share/$${PROJECT_NAME}
qmldir.files += $$TARGET
qmldir.path += $$[QT_INSTALL_IMPORTS]/MeeGo/App

desktop.files += contacts-settings.desktop
desktop.path += $$INSTALL_ROOT/usr/share/meego-ux-settings/apps/

INSTALLS += qmldir qmlfiles desktop

DEFINES += QMLJSDEBUGGER

TRANSLATIONS += *.qml
dist.commands += rm -fR $${PROJECT_NAME}-$${VERSION} &&
dist.commands += git clone . $${PROJECT_NAME}-$${VERSION} &&
dist.commands += rm -fR $${PROJECT_NAME}-$${VERSION}/.git &&
dist.commands += rm -f $${PROJECT_NAME}-$${VERSION}/.gitignore &&
dist.commands += mkdir -p $${PROJECT_NAME}-$${VERSION}/ts &&
dist.commands += lupdate $${TRANSLATIONS} -ts $${PROJECT_NAME}-$${VERSION}/ts/$${PROJECT_NAME}.ts &&
dist.commands += tar jcpvf $${PROJECT_NAME}-$${VERSION}.tar.bz2 $${PROJECT_NAME}-$${VERSION} &&
dist.commands += rm -fR $${PROJECT_NAME}-$${VERSION}
QMAKE_EXTRA_TARGETS += dist
