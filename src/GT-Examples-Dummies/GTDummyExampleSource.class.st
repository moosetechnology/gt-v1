Class {
	#name : #GTDummyExampleSource,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #'bidirectional-example-linking' }
GTDummyExampleSource class >> gtExamplesProvider [
	" Notice: this link is completely OPTIONAL, but it will provide convenience for browsing examples "
	" Usecase: My provider will implement my examples because I'm probably a class with a lot of methods ... "
	^ GTDummyExampleProvider new
]

{ #category : #'dummy-behaviour' }
GTDummyExampleSource >> a [
	" imagine this would be some real stuff "
	^ true
]

{ #category : #'dummy-behaviour' }
GTDummyExampleSource >> b [
	" imagine this would be some real stuff "
	^ false
]
