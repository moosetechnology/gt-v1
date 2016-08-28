Extension { #name : #GTExampleSubject }

{ #category : #'*GT-Examples-UI' }
GTExampleSubject >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]

{ #category : #'*GT-Examples-UI' }
GTExampleSubject >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with Subject ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasSubject: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]
