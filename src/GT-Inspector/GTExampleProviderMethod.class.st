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
	^ arguments ifNil: [ #() ]
]

{ #category : #accessing }
GTExampleProviderMethod >> arguments: anObject [
	arguments := anObject
]

{ #category : #'accessing-defaults' }
GTExampleProviderMethod >> defaultProvider [
	^ [ (Smalltalk classNamed: providerName) gtExamplesProvider ]
		on: Error
		do: [ nil ]
]

{ #category : #testing }
GTExampleProviderMethod >> hasValidArguments [
	^ self exists 
		and: [ self arguments size = self method numArgs ]
]

{ #category : #accessing }
GTExampleProviderMethod >> provider [
	^ provider ifNil: [ provider := self defaultProvider ]
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
