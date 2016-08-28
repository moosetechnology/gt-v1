Extension { #name : #GTExampleMethodAfter }

{ #category : #'*GT-Examples-UI' }
GTExampleMethodAfter >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse after-method "' ,  self method gtDisplayString , '"'
		value: [ self method browse ]
]

{ #category : #'*GT-Examples-UI' }
GTExampleMethodAfter >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with after Method ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasAfter: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]
