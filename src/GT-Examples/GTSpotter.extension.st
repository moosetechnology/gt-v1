Extension { #name : #GTSpotter }

{ #category : #'*GT-Examples-UI' }
GTSpotter >> gtSpotterExamplesFor: aStep [
	<spotterOrder: 41>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ Smalltalk gtExamplesContained ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]
