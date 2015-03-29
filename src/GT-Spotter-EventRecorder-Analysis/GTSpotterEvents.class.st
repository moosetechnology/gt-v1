Class {
	#name : #GTSpotterEvents,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #accessing }
GTSpotterEvents >> duration [
	^ self stop - self start
]

{ #category : #'as yet unclassified' }
GTSpotterEvents >> durationView [
	| b ds |
	b := RTGrapher new.
	b extent: 500 @ 100.
	ds := RTStackedDataSet new.
	ds points: self sessions.
	ds x: #timestamp.
	ds y: [ :c | c duration asSeconds ].
	ds dotShape rectangle color: Color green.
	ds barShape color: Color blue; width: 10.
	b add: ds.
	b axisX.
	b axisY.
	b axisYWithNumberOfTicks: 4.
	b build.
	^ b view.
	
]

{ #category : #accessing }
GTSpotterEvents >> filter [
	^ GTSpotterFilter executeOn: self copy
]

{ #category : #'as yet unclassified' }
GTSpotterEvents >> gtInspectorDurationViewIn: composite [
	<gtInspectorPresentationOrder: 5>
	composite roassal2
		title: 'Duration';
		initializeView: [ self durationView ]
		
]

{ #category : #'as yet unclassified' }
GTSpotterEvents >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Sessions';
		display: [ :anEvent | anEvent sessions ];
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each value duration ];
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each value size ];
		showOnly: 50
]

{ #category : #enumerating }
GTSpotterEvents >> sessions [
	| borders pairs openOrExit |
	borders := self withIndexCollect: [ :event :index |
		(event isExit or: [ event isOpen ]) 
				ifTrue: [ index -> event ]
				ifFalse: [ nil ]
		 ].
	borders := borders select: [ :each | each notNil ].
	pairs := OrderedCollection new.
	openOrExit := #open.
	borders do: [ :eachAssociation |
		(openOrExit = #open) 
			ifTrue: [ 
				eachAssociation value isOpen ifTrue: [ 
					pairs addLast: eachAssociation. 
					openOrExit := #exit ] ]
			ifFalse: [ 
				eachAssociation value isExit ifTrue: [ 
					pairs at: (pairs size) put: (pairs last) -> eachAssociation. 
					openOrExit := #open ] ]
		 ].
	openOrExit = #exit ifTrue: [ pairs removeLast ].
	^ pairs collect: [ :eachPair | | open exit |
		open := eachPair key.
		exit := eachPair value.
		self copyFrom: open key to: exit key.
		 ] as: GTSpotterSessions.
]

{ #category : #accessing }
GTSpotterEvents >> start [
	^ self first timestamp
]

{ #category : #accessing }
GTSpotterEvents >> stop [
	^ self last timestamp
]
