Extension { #name : #TClass }

{ #category : #'*GT-Examples-UI' }
TClass >> gtInspectorGTExamplesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Examples';
		display: [ self gtExamples ];
		icon: [:each | each icon];
		format: [ :each | each gtDisplayString ] ;
		send: [ :each | each returnValue ];
		when: [ self gtExamples notEmpty ]
]

{ #category : #'*GT-Examples-UI' }
TClass >> gtSpotterGTExampleSubjectsFor: aStep [
	<spotterOrder: 101>
	aStep listProcessor
		title: 'Example Subject';
		items: [ { self asGTExampleSubject } ];
		itemName: [ :subject | subject gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-UI' }
TClass >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		items: [ self gtExamples ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]
