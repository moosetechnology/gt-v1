Class {
	#name : #GTExampleMethod,
	#superclass : #Object,
	#instVars : [
		'provider',
		'providerName',
		'selector'
	],
	#category : #'GT-Inspector-Examples-Utils'
}

{ #category : #testing }
GTExampleMethod >> = anExampleMethod [
	^ self class = anExampleMethod class 
		and: [ self provider = anExampleMethod provider 
			and: [ self selector = anExampleMethod selector ] ]
]

{ #category : #testing }
GTExampleMethod >> exists [
	^ self providerClass notNil
		and: [ self providerClass includesSelector: self selector ]
]

{ #category : #public }
GTExampleMethod >> hash [
	^ (self class hash 
		bitXor: self provider hash)
			bitXor: self selector hash
]

{ #category : #testing }
GTExampleMethod >> matchesMethod: aCompiledMethod [
	^ self exists
		and: [ self method = aCompiledMethod ]
]

{ #category : #public }
GTExampleMethod >> method [
	^ self providerClass >> self selector
]

{ #category : #accessing }
GTExampleMethod >> provider [
	^ provider ifNil: [ provider := Smalltalk classNamed: providerName ]
]

{ #category : #accessing }
GTExampleMethod >> provider: anObject [
	provider := anObject.
	providerName := nil.
]

{ #category : #public }
GTExampleMethod >> providerClass [
	^ self provider class
]

{ #category : #accessing }
GTExampleMethod >> providerName: anObject [
	providerName := anObject.
	provider := nil.
]

{ #category : #accessing }
GTExampleMethod >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleMethod >> selector: anObject [
	selector := anObject
]
