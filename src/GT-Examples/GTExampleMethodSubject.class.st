"
I describe a method subject of an example. I should be a subclas of GTExampleSubject, but for now I am external because it seems I have more in common in terms of implementation to GTExampleMethod.
"
Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Subjects'
}

{ #category : #'accessing-dynamic' }
GTExampleMethodSubject >> asGTExampleSubject [
	^ self
]

{ #category : #'*GT-Examples-UI' }
GTExampleMethodSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse subject Method ' ,  self method gtDisplayString
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
