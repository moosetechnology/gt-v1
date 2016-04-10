Class {
	#name : #GTExampleProviderMethod,
	#superclass : #GTExampleMethod,
	#instVars : [
		'providerName',
		'arguments'
	],
	#category : #'GT-Inspector-Examples-Utils'
}

{ #category : #accessing }
GTExampleProviderMethod >> arguments [
	^ arguments
]

{ #category : #accessing }
GTExampleProviderMethod >> arguments: anObject [
	arguments := anObject
]

{ #category : #'as yet unclassified' }
GTExampleProviderMethod >> hasValidArguments [
	^ self arguments size = self method numArgs
]

{ #category : #accessing }
GTExampleProviderMethod >> provider [
	^ provider ifNil: [ provider := Smalltalk classNamed: providerName ]
]

{ #category : #accessing }
GTExampleProviderMethod >> provider: anObject [
	provider := anObject.
	providerName := nil.
]

{ #category : #accessing }
GTExampleProviderMethod >> providerName: anObject [
	providerName := anObject.
	provider := nil.
]
