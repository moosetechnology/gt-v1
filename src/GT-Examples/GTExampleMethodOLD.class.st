Class {
	#name : #GTExampleMethodOLD,
	#superclass : #Object,
	#instVars : [
		'provider',
		'selector'
	],
	#category : #'GT-Examples-DEPRECATED'
}

{ #category : #testing }
GTExampleMethodOLD >> = anExampleMethod [
	^ self class = anExampleMethod class 
		and: [ self provider = anExampleMethod provider 
			and: [ self selector = anExampleMethod selector ] ]
]

{ #category : #testing }
GTExampleMethodOLD >> exists [
	^ self provider notNil
		and: [ self providerClass notNil
			and: [ self providerClass includesSelector: self selector ] ]
]

{ #category : #testing }
GTExampleMethodOLD >> hasValidArguments [
	^ true
]

{ #category : #public }
GTExampleMethodOLD >> hash [
	^ (self class hash 
		bitXor: self provider hash)
			bitXor: self selector hash
]

{ #category : #testing }
GTExampleMethodOLD >> matchesMethod: aCompiledMethod [
	^ self exists
		and: [ self method = aCompiledMethod ]
]

{ #category : #public }
GTExampleMethodOLD >> method [
	^ self providerClass >> self selector
]

{ #category : #accessing }
GTExampleMethodOLD >> provider [
	^ provider
]

{ #category : #accessing }
GTExampleMethodOLD >> provider: anObject [
	provider := anObject
]

{ #category : #public }
GTExampleMethodOLD >> providerClass [
	^ self provider class
]

{ #category : #accessing }
GTExampleMethodOLD >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleMethodOLD >> selector: anObject [
	selector := anObject
]
