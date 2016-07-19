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

{ #category : #private }
GTExampleFormIcon >> basicForm [
	^ [ GTExampleMethodIcon 
		perform: self converter 
		withArguments: self arguments ] on: Error do: [ nil ]
]

{ #category : #testing }
GTExampleFormIcon >> exists [
	^ self form notNil
]

{ #category : #accessing }
GTExampleFormIcon >> form [
	^ form ifNil: [ form := self basicForm ]
]
