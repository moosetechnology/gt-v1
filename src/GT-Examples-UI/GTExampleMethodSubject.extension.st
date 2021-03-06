Extension { #name : #GTExampleMethodSubject }

{ #category : #'*GT-Examples-UI' }
GTExampleMethodSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse method-subject "' ,  self method gtDisplayString , '"'
		value: [ self method browse ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleMethodSubject >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with Subject ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasSubject: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]
