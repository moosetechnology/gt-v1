Class {
	#name : #GTAbstractExampleMethod,
	#superclass : #Object,
	#instVars : [
		'methodClassName',
		'methodClass',
		'meta',
		'selector'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleMethod >> = anExampleMethod [
	^ self class = anExampleMethod class 
		and: [ self methodClassName = anExampleMethod methodClassName 
			and: [ self meta = anExampleMethod meta
				and: [ self selector = anExampleMethod selector ] ] ]
]

{ #category : #private }
GTAbstractExampleMethod >> ensure [
	" 1) reset "
	methodClass ifNotNil: [ methodClass isObsolete ifTrue: [ methodClass := nil ] ].
	
	" 1) reinitialize "
	methodClass	ifNil: [ methodClass := self meta 
			ifTrue: [ (Smalltalk classNamed: self methodClassName) class ] 
			ifFalse: [ Smalltalk classNamed: self methodClassName ] ]
		
]

{ #category : #testing }
GTAbstractExampleMethod >> exists [
	^ self methodClassName notNil
		and: [ self methodClass notNil
			and: [ self methodClass includesSelector: self selector ] ]
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> gtExample [
	^ self hasExample 
		ifTrue: [ self method gtExample ]
		ifFalse: [ nil ]
]

{ #category : #testing }
GTAbstractExampleMethod >> hasExample [
	^ self exists
		and: [ self method isGTExampleMethod ]
]

{ #category : #testing }
GTAbstractExampleMethod >> hasMethod [
	^ self exists
]

{ #category : #testing }
GTAbstractExampleMethod >> hash [
	^ ((self class hash 
		bitXor: self methodClassName hash)
			bitXor: self meta hash)
				bitXor: self selector hash
]

{ #category : #testing }
GTAbstractExampleMethod >> isValid [
	^ self exists
]

{ #category : #testing }
GTAbstractExampleMethod >> matchesExample: aGTExample [
	^ self exists 
		and: [ aGTExample isGTExample
			and: [ aGTExample methodClass = self methodClass
				and: [ aGTExample selector = self selector ] ] ]
]

{ #category : #testing }
GTAbstractExampleMethod >> matchesMethod: aCompiledMethod [
	^ self exists
		and: [ self methodClass = aCompiledMethod methodClass
			and: [ self selector = aCompiledMethod selector ] ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> meta [
	^ meta
]

{ #category : #accessing }
GTAbstractExampleMethod >> meta: anObject [
	meta := anObject
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> method [
	^ self exists 
		ifTrue: [ self methodClass >> self selector ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClass [
	self ensure.
	^ methodClass
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClass: anObject [
	methodClass := anObject
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClassName [
	^ methodClassName
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClassName: anObject [
	methodClassName := anObject
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> provider [ 
	^ self meta
		ifTrue: [ self methodClass ]
		ifFalse: [ self methodClass new ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> selector [
	^ selector
]

{ #category : #accessing }
GTAbstractExampleMethod >> selector: anObject [
	selector := anObject
]
