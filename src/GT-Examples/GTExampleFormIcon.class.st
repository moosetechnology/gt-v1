Class {
	#name : #GTExampleFormIcon,
	#superclass : #GTAbstractExampleIcon,
	#instVars : [
		'arguments',
		'converter',
		'form'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #accessing }
GTExampleFormIcon >> arguments [
	^ arguments
]

{ #category : #accessing }
GTExampleFormIcon >> arguments: anObject [
	arguments := anObject
]

{ #category : #private }
GTExampleFormIcon >> basicForm [
	^ [ GTExampleMethodIcon 
		perform: self converter 
		withArguments: self arguments ] on: Error do: [ nil ]
]

{ #category : #accessing }
GTExampleFormIcon >> converter [
	^ converter
]

{ #category : #accessing }
GTExampleFormIcon >> converter: anObject [
	converter := anObject
]

{ #category : #testing }
GTExampleFormIcon >> exists [
	^ self converter notNil
		and: [ (GTExampleMethodIcon includesSelector: self converter)
			and: [ self form notNil ] ]
]

{ #category : #accessing }
GTExampleFormIcon >> form [
	^ form ifNil: [ form := self basicForm ]
]