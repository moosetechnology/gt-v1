Class {
	#name : #GTExampleAspect,
	#superclass : #Object,
	#category : #'GT-Examples-Organization'
}

{ #category : #testing }
GTExampleAspect class >> isAbstract [
	^ self == GTExampleAspect
]

{ #category : #'*GT-Examples-UI' }
GTExampleAspect >> addToSelectorEnvironment: aSelectorEnvironment [
]

{ #category : #testing }
GTExampleAspect >> exists [
	^ false
]

{ #category : #'*GT-Examples-UI' }
GTExampleAspect >> forNautilus: aBlock [
	
]

{ #category : #'*GT-Examples-UI' }
GTExampleAspect >> gtDisplayValidityOn: aStream [
	self isValid ifTrue: [ ^ self ].
	
	self exists ifFalse: [ ^ aStream nextPutAll: ' [does not exist]' ].
	aStream nextPutAll: ' [invalid]'
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
