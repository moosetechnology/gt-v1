Extension { #name : #GTExampleOrganizer }

{ #category : #'*GT-Examples-UI' }
GTExampleOrganizer >> gtInspectorExamplesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Examples';
		display: [ self gtExamplesContained ];
		format: [ :each | each gtDisplayString ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleOrganizer >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		filter: GTNullFilter item: [ :filter :context | 
			self examplesDo: [ :cn :s :example | filter value: example ] ]
]
