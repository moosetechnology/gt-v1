Class {
	#name : #GTInspectorPragmaFilterStrategy,
	#superclass : #GTInspectorPresentationFilterStrategy,
	#instVars : [
		'defaultPragmaKey',
		'pragmaKeys'
	],
	#category : #'GT-Inspector'
}

{ #category : #adding }
GTInspectorPragmaFilterStrategy >> addPragmaKey: aSymbol [

	pragmaKeys add: aSymbol
]

{ #category : #accessing }
GTInspectorPragmaFilterStrategy >> defaultInspectorPragmaKey: aSymbol [

	defaultPragmaKey := aSymbol
]

{ #category : #initialization }
GTInspectorPragmaFilterStrategy >> initialize [
	super initialize.
	
	pragmaKeys := OrderedCollection new.
	defaultPragmaKey := #gtInspectorTagDefault
]

{ #category : #accessing }
GTInspectorPragmaFilterStrategy >> inspectorPragmasFrom: aMethod [

	^ (aMethod pragmas select: [ :each | each key beginsWith: #gtInspectorTag ]) 
		ifEmpty: [ defaultPragmaKey ifNil: [ {  } ] ifNotNil: [ { defaultPragmaKey } ] ]
		ifNotEmpty: [ :currentPragmas | currentPragmas collect: [ :each | each key ] ]
]

{ #category : #testing }
GTInspectorPragmaFilterStrategy >> shouldDisplayPresentationCreateBy: aMethod [

	^ (self inspectorPragmasFrom: aMethod) includesAny: pragmaKeys
]
