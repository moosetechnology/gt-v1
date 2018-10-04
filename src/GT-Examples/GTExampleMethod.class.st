Class {
	#name : #GTExampleMethod,
	#superclass : #GTAbstractExampleMethod,
	#instVars : [
		'arguments'
	],
	#category : #'GT-Examples-Organization'
}

{ #category : #accessing }
GTExampleMethod >> arguments [
	^ arguments ifNil: [ #() ]
]

{ #category : #accessing }
GTExampleMethod >> arguments: anObject [
	arguments := anObject
]

{ #category : #'accessing-dynamic' }
GTExampleMethod >> asGTExampleSubject [
	^ GTExampleMethodSubject fromClass: self methodClass selector: self selector
]

{ #category : #'accessing-dynamic' }
GTExampleMethod >> gtExample [
	^ self hasExample 
		ifTrue: [ self method gtExample ]
		ifFalse: [ nil ]
]

{ #category : #testing }
GTExampleMethod >> hasArguments [
	^ self arguments notEmpty
]

{ #category : #testing }
GTExampleMethod >> hasExample [
	^ self exists
		and: [ self method isGTExampleMethod ]
]

{ #category : #testing }
GTExampleMethod >> hasValidArguments [
	^ self exists 
		and: [ self arguments size = self method numArgs ]
]

{ #category : #testing }
GTExampleMethod >> isValid [
	^ super isValid 
		and: [ self hasValidArguments ]
]

{ #category : #testing }
GTExampleMethod >> matchesExample: aGTExample [
	^ self exists 
		and: [ aGTExample isGTExample
			and: [ aGTExample methodClass = self methodClass
				and: [ aGTExample selector = self selector ] ] ]
]
