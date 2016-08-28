"
I am the abstract of a description of a subject of an example. The concrete subclasses encapsulate the links to the concrete subjects.

For example, the goal of an example might be to exemplify the way an instance of a class X can look like. In this case,  the subject is the class X. Or, the goal of the example might be to instantiate class X and in this case, the subject can be the instantiating method.

The subject information is useful both when understanding the goal of an example, and to link examples to the static entities. For example, if a class has examples associated, these can appear in the static code browser, or in the inspector of the class.
"
Class {
	#name : #GTExampleSubject,
	#superclass : #GTExampleAspect,
	#category : #'GT-Examples-Subjects'
}

{ #category : #testing }
GTExampleSubject class >> isAbstract [
	^ self == GTExampleSubject
]

{ #category : #testing }
GTExampleSubject >> = anExampleSubject [
	^ self subclassResponsibility
]

{ #category : #converting }
GTExampleSubject >> asGTExampleSubject [
	^ self
]

{ #category : #'accessing-dynamic' }
GTExampleSubject >> gtExamplesContained [
	^ Smalltalk gtExamplesContained select: [ :each | each hasSubject: self ]
]

{ #category : #converting }
GTExampleSubject >> gtExamplesSubjects [
	^ { self }
]

{ #category : #testing }
GTExampleSubject >> hash [
	^ self subclassResponsibility
]
