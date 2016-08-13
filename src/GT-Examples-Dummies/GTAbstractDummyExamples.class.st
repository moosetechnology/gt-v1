Class {
	#name : #GTAbstractDummyExamples,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #testing }
GTAbstractDummyExamples class >> isAbstract [
	^ self == GTAbstractDummyExamples 
]

{ #category : #testing }
GTAbstractDummyExamples class >> isExpectedFailure [
	^ false
]

{ #category : #testing }
GTAbstractDummyExamples class >> isExpectedRecursion [
	^ false
]
