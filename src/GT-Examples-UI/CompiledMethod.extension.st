Extension { #name : #CompiledMethod }

{ #category : #'*GT-Examples-UI' }
CompiledMethod >> gtSpotterGTExampleSubjectsFor: aStep [
	<spotterOrder: 101>
	aStep listProcessor
		title: 'Example Subject';
		items: [ { self asGTExampleSubject } ];
		itemName: [ :subject | subject gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-UI' }
CompiledMethod >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 12>
	aStep listProcessor
		title: 'Examples';
		items: [ self gtExamples ];
		filter: GTFilterSubstring
]
