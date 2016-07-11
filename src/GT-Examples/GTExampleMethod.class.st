Class {
	#name : #GTExampleMethod,
	#superclass : #GTAbstractExampleMethod,
	#instVars : [
		'arguments'
	],
	#category : #'GT-Examples-Utils'
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
	^ GTExampleMethodSubject new 
		methodClassName: self methodClassName;
		methodClass: self methodClass;
		selector: self selector;
		yourself
]

{ #category : #ui }
GTExampleMethod >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse dependency Method ' ,  self method gtDisplayString
		value: [ self method browse ]
]

{ #category : #testing }
GTExampleMethod >> hasArguments [
	^ self arguments notEmpty
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
