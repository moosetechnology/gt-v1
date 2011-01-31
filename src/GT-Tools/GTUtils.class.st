Class {
	#name : #GTUtils,
	#superclass : #Object,
	#instVars : [
		'title'
	],
	#category : #'GT-Tools-Utils'
}

{ #category : #'as yet unclassified' }
GTUtils class >> browseMethod: aCompiledMethod [
	ToolSet 
		browse: aCompiledMethod methodClass 
		selector: aCompiledMethod selector
]

{ #category : #'as yet unclassified' }
GTUtils class >> printCompiledMethod: method [
	^ String streamContents: [:stream | stream print: method methodClass; nextPutAll: '>>'; nextPutAll: method selector storeString]
]
