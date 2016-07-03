Class {
	#name : #GTExampleMethod,
	#superclass : #Object,
	#instVars : [
		'methodClassName',
		'methodClass',
		'selector',
		'arguments'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleMethod >> = anExampleMethod [
	^ self class = anExampleMethod class 
		and: [ self provider = anExampleMethod provider 
			and: [ self selector = anExampleMethod selector ] ]
]

{ #category : #accessing }
GTExampleMethod >> arguments [
	^ arguments ifNil: [ #() ]
]

{ #category : #accessing }
GTExampleMethod >> arguments: anObject [
	arguments := anObject
]

{ #category : #private }
GTExampleMethod >> ensure [
	methodClass 
		ifNil: [ methodClass := Smalltalk classNamed: self methodClassName ]
		ifNotNil: [ methodClass isObsolete ifTrue: [ methodClass := nil ] ]
]

{ #category : #testing }
GTExampleMethod >> exists [
	^ self provider notNil
		and: [ self providerClass notNil
			and: [ self providerClass includesSelector: self selector ] ]
]

{ #category : #'accessing-dynamic' }
GTExampleMethod >> gtExample [
	^ self hasExample 
		ifTrue: [ self method gtExample ]
		ifFalse: [ nil ]
]

{ #category : #testing }
GTExampleMethod >> hasExample [
	self exists
		and: [ self method isGTExampleMethod ]
]

{ #category : #testing }
GTExampleMethod >> hasValidArguments [
	^ true
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
GTExampleMethod >> methodClass [
	^ methodClass
]

{ #category : #accessing }
GTExampleMethod >> methodClass: anObject [
	methodClass := anObject
]

{ #category : #accessing }
GTExampleMethod >> methodClassName [
	^ methodClassName
]

{ #category : #accessing }
GTExampleMethod >> methodClassName: anObject [
	methodClassName := anObject
]

{ #category : #accessing }
GTExampleMethod >> provider [
	^ provider
]

{ #category : #accessing }
GTExampleMethod >> provider: anObject [
	provider := anObject
]

{ #category : #public }
GTExampleMethod >> providerClass [
	^ self provider class
]

{ #category : #accessing }
GTExampleMethod >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleMethod >> selector: anObject [
	selector := anObject
]
