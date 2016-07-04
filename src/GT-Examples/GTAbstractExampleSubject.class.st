Class {
	#name : #GTAbstractExampleSubject,
	#superclass : #Object,
	#category : #'GT-Examples-Utils'
}

{ #category : #UI }
GTAbstractExampleSubject >> addToSelectorEnvironment: aSelectorEnvironment [
]

{ #category : #converting }
GTAbstractExampleSubject >> asGTExampleSubject [
	^ self
]

{ #category : #testing }
GTAbstractExampleSubject >> exists [
	self subclassResponsibility
]

{ #category : #UI }
GTAbstractExampleSubject >> forNautilus: aBlock [
	
]

{ #category : #UI }
GTAbstractExampleSubject >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with Subject ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasSubject: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #testing }
GTAbstractExampleSubject >> hasLiteralThorough: aLiteral [
	^ false
]
