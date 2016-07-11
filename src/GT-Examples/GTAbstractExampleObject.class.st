Class {
	#name : #GTAbstractExampleObject,
	#superclass : #Object,
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleObject class >> isAbstract [
	^ self == GTAbstractExampleObject
]

{ #category : #UI }
GTAbstractExampleObject >> addToSelectorEnvironment: aSelectorEnvironment [
]

{ #category : #private }
GTAbstractExampleObject >> ensureInitialized [
]

{ #category : #testing }
GTAbstractExampleObject >> exists [
	^ false
]

{ #category : #UI }
GTAbstractExampleObject >> forNautilus: aBlock [
	
]

{ #category : #testing }
GTAbstractExampleObject >> hasLiteralThorough: aLiteral [
	^ false
]

{ #category : #testing }
GTAbstractExampleObject >> isAbstract [
	^ self class isAbstract
]
