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
		and: [ self methodClassName = anExampleMethod methodClassName 
			and: [ self methodClass = anExampleMethod methodClass
				and: [ self selector = anExampleMethod selector ] ] ]
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
	^ self methodClassName notNil
		and: [ self methodClass notNil
			and: [ self methodClass includesSelector: self selector ] ]
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
	^ self exists 
		and: [ self arguments size = self method numArgs ]
]

{ #category : #testing }
GTExampleMethod >> hash [
	^ ((self class hash 
		bitXor: self methodClassName hash)
			bitXor: self methodClass hash)
				bitXor: self selector hash
]

{ #category : #testing }
GTExampleMethod >> matchesExample: aGTExample [
	^ self exists 
		and: [ aGTExample isGTExample
			and: [ aGTExample methodClass = self methodClass
				and: [ aGTExample selector = self selector ] ] ]
]

{ #category : #testing }
GTExampleMethod >> matchesMethod: aCompiledMethod [
	^ self exists
		and: [ self methodClass = aCompiledMethod methodClass
			and: [ self selector = aCompiledMethod selector ] ]
]

{ #category : #'accessing-dynamic' }
GTExampleMethod >> method [
	^ self exists 
		ifTrue: [ self methodClass >> self selector ]
		ifFalse: [ nil ]
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
GTExampleMethod >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleMethod >> selector: anObject [
	selector := anObject
]
