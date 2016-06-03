/*
  Copyright (C) 2016 jollailija
  Contact: jollailija <jollailija@gmail.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * The names of the contributors may not be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtQuick.LocalStorage 2.0
import "storage.js" as Storage

Page {
    id: firstPage
    allowedOrientations: Orientation.All
    BookmarkPage {id: bookmarkPage} // just don't. I know it's wrong, but the freaking bug won't die!

    property bool zoom: false // This is for choosing the pixelratiohack

    // Workaround for 'High Power Consumption' webkit bug by mkiol
    Connections {
        target: Qt.application
        onActiveChanged: {
            if(!Qt.application.active && settings.powerSaveMode) {
                pageStack.pop();
            }
        }
    }

    onStatusChanged: {
        if (status === PageStatus.Active && pageStack.depth === 1) {
            pageStack.pushAttached("HylePage.qml", {});
        }
    }

    DockedPanel {
        id: navPanel
        dock: Dock.Bottom
        width: parent.width
        height: Theme.itemSizeSmall
        open: true // todo: open and close on scroll
        _immediate: true // no lag when opening or closing

        IconButton {
            icon.source: "image://theme/icon-m-back"
            anchors {
                left: parent.Left
                margins: Theme.paddingLarge
            }
            onClicked: webView.goBack()
            enabled: webView.canGoBack
        }
        Row {
            anchors.centerIn: parent
            spacing: Theme.paddingLarge
            IconButton {
                icon.source: "image://theme/icon-m-favorite"
                onClicked: pageStack.push(bookmarkPage,{"name": webView.title, "url": webView.url})
            }
            IconButton {
                icon.source: "image://theme/icon-m-refresh"
                onClicked: webView.reload()
            }
        }
    }

    // Rewritten for easier readability: all important stuff is at the top
    SilicaWebView {
        id: webView
        _allowFocusAnimation: false
        anchors {
            fill: parent
            bottomMargin: navPanel.visibleSize
        }
        url: "http://tv.zam.it/gadget/gadget_tv.php?fsize=20"
        PullDownMenu {
            MenuLabel {
                text: qsTr("Guida TV Italia") + " 0.1.1"
            }
            MenuItem {
                text: navPanel.open ? qsTr("Hide navigation bar")
                                : qsTr("Open navigation bar")
                onClicked: {
                    navPanel.open ? navPanel.open = false : navPanel.open = true
                }
            }
            MenuItem {
                text: qsTr("Open in browser")
                onClicked: Qt.openUrlExternally(webView.url)
            }
        }
        BusyIndicator {
            anchors.centerIn: parent
            running: webView.loading
            size: BusyIndicatorSize.Large
        }
        experimental.userScripts: [
            Qt.resolvedUrl("devicePixelRatioHack.js"),
        ]

        onNavigationRequested: {
          var stringurl = request.url.toString();

          if(stringurl.indexOf("fsize=") === -1) {
            request.action = WebView.IgnoreRequest;
            webView.url = stringurl += "?&fsize=20";
          }
        }

    }
}
