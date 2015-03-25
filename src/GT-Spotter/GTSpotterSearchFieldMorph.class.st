Class {
	#name : #GTSpotterSearchFieldMorph,
	#superclass : #RubTextFieldMorph,
	#category : #'GT-Spotter-UI'
}

{ #category : #geometry }
GTSpotterSearchFieldMorph >> extent: aPoint [
	super extent: aPoint.
	
	self owner ifNotNil: [
		"to center text area"
		self owner marginTop: (self brickThemer spotterThemer headerHeight - self textArea height) / 2 ]
]

{ #category : #accessing }
GTSpotterSearchFieldMorph >> getMenuSelector: aSymbol [
]

{ #category : #actions }
GTSpotterSearchFieldMorph >> moveCursorAtTheEnd [

	self moveCursorToIndex: (self text size + 1)
]

{ #category : #'initialize-release' }
GTSpotterSearchFieldMorph >> newScrollPane [
	"using hacked ScrollPane to remove focus border"
	| sp |
	sp := GTSpotterSearchFieldScrollPane new.
	sp scrollTarget: self defaultScrollTarget.
	^ sp
]
