Extension { #name : #GTExampleOrganizer }

{ #category : #'*GT-Examples-UI' }
GTExampleOrganizer >> gtInspectorExamplesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Examples';
		display: [ self gtExamplesContained ];
		format: [ :each | each gtDisplayString ]
]
