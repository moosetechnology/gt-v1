Class {
	#name : #GTAbstractExampleSubject,
	#superclass : #GTAbstractExampleObject,
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleSubject class >> isAbstract [
	^ self == GTAbstractExampleSubject
]

{ #category : #testing }
GTAbstractExampleSubject >> = anExampleSubject [
	^ self subclassResponsibility
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

{ #category : #'accessing-dynamic' }
GTAbstractExampleSubject >> gtExamplesContained [
	^ Smalltalk gtExamplesContained select: [ :each | each hasSubject: self ]
]

{ #category : #converting }
GTAbstractExampleSubject >> gtExamplesSubjects [
	^ { self }
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
GTAbstractExampleSubject >> hash [
	^ self subclassResponsibility
]
