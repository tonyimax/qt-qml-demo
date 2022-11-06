QT += qml quick winextras
CONFIG += c++11
SOURCES += main.cpp
RESOURCES += qml.qrc
win32{
    RESOURCES += WinExtras.qrc
    RC_FILE = WinExtras.rc
}
