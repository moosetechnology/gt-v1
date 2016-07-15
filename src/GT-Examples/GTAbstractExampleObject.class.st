Class {
	#name : #GTAbstractExampleObject,
	#superclass : #Object,
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleObject class >> isAbstract [
	^ self == GTAbstractExampleObject
]

{ #category : #ui }
GTAbstractExampleObject >> addToSelectorEnvironment: aSelectorEnvironment [
]

{ #category : #private }
GTAbstractExampleObject >> ensureInitialized [
]

{ #category : #testing }
GTAbstractExampleObject >> exists [
	^ false
]

{ #category : #ui }
GTAbstractExampleObject >> forNautilus: aBlock [
	
]

{ #category : #ui }
GTAbstractExampleObject >> gtDisplayValidityOn: aStream [
	self isValid ifTrue: [ ^ self ].
	
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
