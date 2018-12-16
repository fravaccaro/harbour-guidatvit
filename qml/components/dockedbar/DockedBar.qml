import QtQuick 2.0
import Sailfish.Silica 1.0
import ".."

Item
{
    readonly property var currentPage: pageStack.currentPage

    id: dockedbar
    width: parent.width
    height: Theme.itemSizeLarge

    Separator {
        id: dockedbarSeparator
        width: parent.width
        color: Theme.primaryColor
        horizontalAlignment: Qt.AlignHCenter
    }

    BackgroundRectangle { anchors.fill: parent }

    Row {
        Item {
            width: dockedbar.width/5
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-back"
                onClicked: webView.goBack()
                enabled: webView.canGoBack
            }
        }

        Item {
            width: dockedbar.width/5
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-forward"
                onClicked: webView.goForward()
                enabled: webView.canGoForward
            }
        }

        Item {
            width: dockedbar.width/5
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-home"
                onClicked: webView.url = "https://guidatv.quotidiano.net/"
            }
        }

        Item {
            width: dockedbar.width/5
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-refresh"
                onClicked: webView.reload()
            }
        }

        Item {
            width: dockedbar.width/5
            height: Theme.itemSizeLarge
            IconButton {
                anchors.centerIn: parent
                icon.source: "image://theme/icon-m-favorite"
                onClicked: pageStack.push(bookmarkPage,{"name": webView.title, "url": webView.url})
            }
        }

    }
}
