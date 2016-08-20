"
I am the abstract of a description of a subject of an example. The concrete subclasses encapsulate the links to the concrete subjects.

For example, the goal of an example might be to exemplify the way an instance of a class X can look like. In this case,  the subject is the class X. Or, the goal of the example might be to instantiate class X and in this case, the subject can be the instantiating method.

The subject information is useful both when understanding the goal of an example, and to link examples to the static entities. For example, if a class has examples associated, these can appear in the static code browser, or in the inspector of the class.
"
Class {
	#name : #GTAbstractExampleSubject,
	#superclass : #GTExampleAspect,
	#category : #'GT-Examples-Subjects'
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

{ #category : #'*GT-Examples-UI' }
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

{ #category : #'*GT-Examples-UI' }
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
