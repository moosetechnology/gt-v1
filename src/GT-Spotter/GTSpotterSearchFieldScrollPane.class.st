Class {
	#name : #GTSpotterSearchFieldScrollPane,
	#superclass : #RubTextScrollPane,
	#category : #'GT-Spotter-UI'
}

{ #category : #drawing }
GTSpotterSearchFieldScrollPane >> drawKeyboardFocusOn: aCanvas [
	"empty to remove focus border"
]

{ #category : #'as yet unclassified' }
GTSpotterSearchFieldScrollPane >> hScrollbarInterval [
	"Answer the computed size of the thumb of the horizontal scrollbar."
	self scrollTarget width = 0 ifTrue: [ ^ 0 ].
	^self scrollBounds width asFloat / self scrollTarget width min: 1.0.
]
