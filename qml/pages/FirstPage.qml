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
import "../components"
import "../components/dockedbar"

Page {
    id: page
    focus: true

    property string webviewurl
    BookmarkPage {id: bookmarkPage} // just don't. I know it's wrong, but the freaking bug won't die!

    property bool zoom: false // This is for choosing the pixelratiohack

    Timer {
        id: timer
        interval: 120000
        repeat: true
        onTriggered: pageStack.replace('IdlePage.qml', { "webviewurl": webView.url })
    }

    Connections {
        target: Qt.application
        onActiveChanged: {
            if(!Qt.application.active) {
                timer.restart()
            } else {
                timer.stop()
            }
        }
    }

    Keys.onPressed: {
           handleKeyPressed(event);
       }

       function handleKeyPressed(event) {

           if (event.key === Qt.Key_Down) {
               webView.flick(0, - page.height);
               event.accepted = true;
           }

           if (event.key === Qt.Key_Up) {
               webView.flick(0, page.height);
               event.accepted = true;
           }

           if (event.key === Qt.Key_PageDown) {
               webView.scrollToBottom();
               event.accepted = true;
           }

           if (event.key === Qt.Key_PageUp) {
               webView.scrollToTop();
               event.accepted = true;
           }

           if (event.key === Qt.Key_B) {
               webView.goBack();
               event.accepted = true;
           }

           if (event.key === Qt.Key_F) {
               webView.goForward();
               event.accepted = true;
           }

           if (event.key === Qt.Key_H) {
               webView.url = "https://guidatv.quotidiano.net/";
               event.accepted = true;
           }

           if (event.key === Qt.Key_R) {
               webView.reload();
               event.accepted = true;
           }
   }

    // Rewritten for easier readability: all important stuff is at the top
    SilicaWebView {
        id: webView
        _allowFocusAnimation: false
        anchors.fill: parent
        anchors.bottomMargin: dockedbar.height
        clip: true
        url: (webviewurl !== "") ? webviewurl : "https://guidatv.quotidiano.net/"

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("./AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Open in browser")
                onClicked: Qt.openUrlExternally(webView.url)
            }
        }

        BusyIndicator {
            id: webViewBusy
            anchors.centerIn: parent
            running: webView.loading
            size: BusyIndicatorSize.Large
        }

         experimental.userScripts: [
             Qt.resolvedUrl("devicePixelRatioHack.js"),
         ]
    }

    DockedBar
    {
        id: dockedbar
        anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
}

}
