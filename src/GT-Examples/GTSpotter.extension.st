Extension { #name : #GTSpotter }

{ #category : #'*GT-Examples-UI' }
GTSpotter >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 41>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ Smalltalk gtExamplesContained ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]
