Class {
	#name : #GTSpotterEvents,
	#superclass : #GTSpotterEventCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #accessing }
GTSpotterEvents >> filter [
	^ GTSpotterFilter executeOn: self copy
]

{ #category : #'gt-inspector-extension' }
GTSpotterEvents >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Sessions';
		display: [ :anEvent | anEvent sessions ];
		column: 'Start' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each start ];
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration ];
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each size ];
		column: 'Preview' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each withPreviewSymbol ];
		column: 'Image Hashes' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each imageHashes size ];
		showOnly: 50
]

{ #category : #accessing }
GTSpotterEvents >> imageHashes [
	self shouldBeImplemented.
]

{ #category : #enumerating }
GTSpotterEvents >> sessions [
	| borders pairs openOrExit |
	borders := self withIndexCollect: [ :event :index |
		(event isCloseSpotter or: [ event isOpenSpotter ]) 
				ifTrue: [ index -> event ]
				ifFalse: [ nil ]
		 ].
	borders := borders select: [ :each | each notNil ].
	pairs := OrderedCollection new.
	openOrExit := #open.
	borders do: [ :eachAssociation |
		(openOrExit = #open) 
			ifTrue: [ 
				eachAssociation value isOpenSpotter ifTrue: [ 
					pairs addLast: eachAssociation. 
					openOrExit := #exit ] ]
			ifFalse: [ 
				eachAssociation value isCloseSpotter ifTrue: [ 
					pairs at: (pairs size) put: (pairs last) -> eachAssociation. 
					openOrExit := #open ] ]
		 ].
	openOrExit = #exit ifTrue: [ pairs removeLast ].
	^ pairs collect: [ :eachPair | | open exit |
		open := eachPair key.
		exit := eachPair value.
		GTSpotterSession withAll: (self copyFrom: open key to: exit key).
		 ] as: GTSpotterSessions.
]
