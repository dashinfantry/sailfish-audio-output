import QtQuick 2.0
import Sailfish.Silica 1.0
import me.henkkalkwater 1.0

CoverBackground {
	id: coverBackground

	Label {
		id: title
		anchors.top: parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		/*: Header of the cover */
		text: qsTr("Audio output")
		color: Theme.primaryColor
		padding: Theme.paddingLarge
	}

	SilicaListView {
		id: coverList
		clip: true
		anchors.top: title.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: coverActionArea.top
		anchors.bottomMargin: Theme.paddingLarge
		model: Ports
		preferredHighlightBegin: y
		preferredHighlightEnd: y + height / 4
		delegate: Label {
			id: outputLabel
			padding: Theme.paddingMedium
			text: model.longName
			font.pixelSize: Theme.fontSizeSmall
			color: model.active ? Theme.primaryColor : Theme.secondaryColor
			width: parent.width
			//elide: "ElideLeft"
			maximumLineCount: 2
			wrapMode: "WordWrap"
		}
		currentIndex: Ports.activeIndex
		snapMode: ListView.SnapToItem
		highlightRangeMode: "StrictlyEnforceRange"
		onModelChanged: console.log("Model updated")
		keyNavigationWraps: true

		function toPrev() {
			var newIndex = Ports.activeIndex - 1;
			if (newIndex < 0) newIndex += Ports.rowCount()
			root.qmlSignal(Ports.sinkOf(newIndex), Ports.nameOf(newIndex))
			Ports.update();
		}
		function toNext() {
			var newIndex = (Ports.activeIndex + 1) % Ports.rowCount();
			root.qmlSignal(Ports.sinkOf(newIndex), Ports.nameOf(newIndex))
			Ports.update();
		}
	}

	CoverActionList {
		id: coverActions

		CoverAction {
			iconSource: "image://theme/icon-cover-previous"
			onTriggered: coverList.toPrev();
		}

		CoverAction {
			iconSource: "image://theme/icon-cover-next"
			onTriggered: coverList.toNext();
		}
	}
}
