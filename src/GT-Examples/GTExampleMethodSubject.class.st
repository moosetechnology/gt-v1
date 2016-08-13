Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Organization'
}

{ #category : #'accessing-dynamic' }
GTExampleMethodSubject >> asGTExampleSubject [
	^ self
]

{ #category : #ui }
GTExampleMethodSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse subject Method ' ,  self method gtDisplayString
		value: [ self method browse ]
]

{ #category : #ui }
GTExampleMethodSubject >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with Subject ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasSubject: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]
