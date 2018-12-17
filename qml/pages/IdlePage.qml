import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
	id: idlePage
    property string webviewurl

       	Connections {
    	   	target: Qt.application
       		onActiveChanged: {
		       	if(Qt.application.active) {
                pageStack.replace('FirstPage.qml', { "webviewurl": webviewurl })
		       	}
		}
	}

	SilicaFlickable {

		ViewPlaceholder {
			enabled: true
			text: qsTr("Idle")
		}
	}        
}
