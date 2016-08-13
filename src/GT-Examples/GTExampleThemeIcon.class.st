Class {
	#name : #GTExampleThemeIcon,
	#superclass : #GTAbstractExampleIcon,
	#instVars : [
		'selector'
	],
	#category : #'GT-Examples-Organization'
}

{ #category : #'instance creation' }
GTExampleThemeIcon class >> fromSelector: aSelector [
	^ self new 
		selector: aSelector;
		yourself
]

{ #category : #'instance creation' }
GTExampleThemeIcon class >> fromString: aString [
	^ self fromSelector: aString asSymbol
]

{ #category : #private }
GTExampleThemeIcon >> basicForm [
	^ Smalltalk ui icons iconNamed: self selector 
]

{ #category : #testing }
GTExampleThemeIcon >> exists [
	^ (Smalltalk ui icons iconNamed: self selector ifNone: [ nil ]) notNil
]

{ #category : #accessing }
GTExampleThemeIcon >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleThemeIcon >> selector: anObject [
	selector := anObject
]
