/*
jollait - Jolla Community Italia WebView. Access to Jolla Community Italia, read news and discuss on the forum.
Copyright (C) 2016,  fravaccaro <fravaccaro90@gmail.com>
All rights reserved.

  Copyright (C) 2015-2016 jollailija
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
    id: page
    allowedOrientations: Orientation.All
    Component.onCompleted: console.log(webView.url)

    property bool zoom: false

    SilicaWebView {
        PullDownMenu {
            MenuLabel {
                text: webView.title
            }
            MenuItem {
                text: qsTr("Reload")
                onClicked: {
                    console.log("Reload")
                    webView.reload()
                }
            }
            MenuItem {
                text: qsTr("Bookmarks")
                onClicked: {
                    console.log("Opening bookmarks")
                    pageStack.push(Qt.resolvedUrl("BookmarkPage.qml"),{"name": webView.title, "url": webView.url})
                }
            }
            MenuItem {
                text: qsTr("Back to home page")
                onClicked: {
                    console.log("Back to home page")
                    webView.url = "http://jollacommunity.it/"
                }
            }
        }
        id: webView
        ViewPlaceholder {
            visible: webView.loading
            text: qsTr("Loading...")
        }

        anchors.fill: parent
        url: window.webViewUrl
        quickScroll : true
        experimental.userScripts: [
            Qt.resolvedUrl("devicePixelRatioHack.js"),
        ]
    }
}
