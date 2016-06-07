import QtQuick 2.1
import Sailfish.Silica 1.0

Page {
	id: idlePage

       	Connections {
    	   	target: Qt.application
       		onActiveChanged: {
		       	if(Qt.application.active) {
				pageStack.replace('FirstPage.qml')
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
