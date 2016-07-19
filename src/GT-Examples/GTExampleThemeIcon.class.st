Class {
	#name : #GTExampleThemeIcon,
	#superclass : #GTAbstractExampleIcon,
	#instVars : [
		'selector'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #private }
GTExampleThemeIcon >> basicForm [
	^ Smalltalk ui icons perform: self selector 
]

{ #category : #testing }
GTExampleThemeIcon >> exists [
	^ Smalltalk ui icons class canPerform: self selector
]
