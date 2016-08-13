Class {
	#name : #GTExampleMethodAfter,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Organization'
}

{ #category : #ui }
GTExampleMethodAfter >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse after Method ' ,  self method gtDisplayString
		value: [ self method browse ]
]

{ #category : #ui }
GTExampleMethodAfter >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with after Method ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasAfter: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]
