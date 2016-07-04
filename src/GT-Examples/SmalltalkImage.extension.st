Extension { #name : #SmalltalkImage }

{ #category : #'*GT-Examples-Core' }
SmalltalkImage >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	Object withAllSubclassesDo: [ :class |
		class gtExamplesFactory examplesDo: [ :example | 
			examples add: example ] ].
	^ examples
]

{ #category : #'*GT-Examples-Core' }
SmalltalkImage class >> gtExamplesFactory [
	^ super gtExamplesFactory
		provider: SmalltalkImage current;
		yourself
]

{ #category : #'*GT-Examples-Core' }
SmalltalkImage >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ self gtExamplesContained ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]
