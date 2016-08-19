Class {
	#name : #GTAbstractExampleObject,
	#superclass : #Object,
	#category : #'GT-Examples-Organization'
}

{ #category : #testing }
GTAbstractExampleObject class >> isAbstract [
	^ self == GTAbstractExampleObject
]

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleObject >> addToSelectorEnvironment: aSelectorEnvironment [
]

{ #category : #testing }
GTAbstractExampleObject >> exists [
	^ false
]

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleObject >> forNautilus: aBlock [
	
]

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleObject >> gtDisplayValidityOn: aStream [
	self isValid ifTrue: [ ^ self ].
	
	self exists ifFalse: [ ^ aStream nextPutAll: ' [does not exist]' ].
	aStream nextPutAll: ' [invalid]'
]

{ #category : #testing }
GTAbstractExampleObject >> hasLiteralThorough: aLiteral [
	^ false
]

{ #category : #testing }
GTAbstractExampleObject >> isAbstract [
	^ self class isAbstract
]

{ #category : #testing }
GTAbstractExampleObject >> isValid [
	^ self exists
]

{ #category : #private }
GTAbstractExampleObject >> resetStub [
]
