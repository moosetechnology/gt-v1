Class {
	#name : #GTAbstractExampleSubject,
	#superclass : #GTAbstractExampleObject,
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleSubject class >> isAbstract [
	^ self == GTAbstractExampleSubject
]

{ #category : #converting }
GTAbstractExampleSubject >> asGTExampleSubject [
	^ self
]

{ #category : #UI }
GTAbstractExampleSubject >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]

{ #category : #ui }
GTAbstractExampleSubject >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with Subject ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasSubject: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]
