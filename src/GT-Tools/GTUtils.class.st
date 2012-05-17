Class {
	#name : #GTUtils,
	#superclass : #Object,
	#instVars : [
		'title'
	],
	#category : #'GT-Tools-Utils'
}

{ #category : #utils }
GTUtils class >> browseMethod: aCompiledMethod [
	Smalltalk tools browser 
		fullOnClass: aCompiledMethod methodClass 
		selector: aCompiledMethod selector
]

{ #category : #utils }
GTUtils class >> printCompiledMethod: method [
	^ String streamContents: [:stream | stream print: method methodClass; nextPutAll: '>>'; nextPutAll: method selector storeString]
]
