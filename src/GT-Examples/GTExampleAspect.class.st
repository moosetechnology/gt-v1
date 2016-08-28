Class {
	#name : #GTExampleAspect,
	#superclass : #Object,
	#category : #'GT-Examples-Organization'
}

{ #category : #testing }
GTExampleAspect class >> isAbstract [
	^ self == GTExampleAspect
]

{ #category : #testing }
GTExampleAspect >> exists [
	^ false
]

{ #category : #testing }
GTExampleAspect >> hasLiteralThorough: aLiteral [
	^ false
]

{ #category : #testing }
GTExampleAspect >> isAbstract [
	^ self class isAbstract
]

{ #category : #testing }
GTExampleAspect >> isValid [
	^ self exists
]

{ #category : #private }
GTExampleAspect >> resetStub [
]
