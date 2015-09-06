Extension { #name : #TClass }

{ #category : #'*GT-Inspector-Examples-UI' }
TClass >> gtInspectorGTExamplesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Examples';
		display: [ self gtExamples ];
		icon: #icon;
		format: #gtDisplayString;
		when: [ self gtExamples notEmpty ]
]

{ #category : #'*GT-Inspector-Examples-UI' }
TClass >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ self gtExamples ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]
