Class {
	#name : #GTAComputers,
	#superclass : #GTASomeComputers,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTAComputers >> bookmarks [
	^ self optionAt: #bookmarks ifAbsentPut: [ GTAConfiguration loadBookmarks: self ]
]

{ #category : #'gt-inspector-extension' }
GTAComputers >> gtInspectorBookmarksIn: composite [
	<gtInspectorPresentationOrder: 9>
	(composite table)
		title: 'Bookmarks';
		display: [ :aComputers | aComputers bookmarks ];
		column: 'Description'
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each description ];
		act: [ :Presentation :aComputers | aComputers saveBookmarks ]
			icon: Smalltalk ui icons glamorousSave
			entitled: 'Save bookmarks';
		selectionPopulate: #selection
			entitled: 'Open bookmark'
			with: [ :aTable | aTable rawSelection gtInspectorInterestingObject ];
		beMultiple;
		send: [ :result | | item |
			result ifNotNil: [ item := result collect: #item ].
			GTAMultipleSelectionSendCommand selection: item in: self ];
		showOnly: 50 
]

{ #category : #update }
GTAComputers >> saveBookmarks [
	self bookmarks ifNotEmpty: [ self bookmarks save ]
]
