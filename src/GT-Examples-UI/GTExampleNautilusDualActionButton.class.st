Class {
	#name : #GTExampleNautilusDualActionButton,
	#superclass : #GTAbstractExampleNautilusActionButton,
	#instVars : [
		'result'
	],
	#category : #'GT-Examples-UI'
}

{ #category : #private }
GTExampleNautilusDualActionButton class >> methodUpdated: aCompiledMethod with: aResult [
	MethodWidget methodsIconsCache 
		at: aCompiledMethod 
		ifPresent: [ :array | 
			array second labelGraphic: (self iconForMethod: aCompiledMethod result: aResult) ]
]

{ #category : #private }
GTExampleNautilusDualActionButton >> actionInspectExample [
	^ IconicButton new
		target: self;
		actionSelector: #inspectExample:;
		arguments: { method };
		color: Color transparent;
		helpText: 'Inspect Example';
		extent: 16 @ 8;
		borderWidth: 0
]

{ #category : #private }
GTExampleNautilusDualActionButton >> actionInspectReturnValue [
	^ IconicButton new
		target: self;
		actionSelector: #inspectReturnValue:;
		arguments: { method };
		color: Color transparent;
		helpText: 'Inspect Return-Value';
		extent: 16 @ 8;
		borderWidth: 0
]

{ #category : #order }
GTExampleNautilusDualActionButton >> actionStateToCache [
	"Return the state of the icon for caching purpose"
	^ result 
		ifNil: [ super actionStateToCache ]
		ifNotNil: [ self exampleStateToCache ]
]

{ #category : #private }
GTExampleNautilusDualActionButton >> actions [
	| action1 action2 |
	^ result := ((Morph new
		extent: 16@16;
		color: Color transparent;
		borderWidth: 0;
		changeTableLayout;
		listDirection: #topToBottom;
		addMorph: (action1 := self actionInspectExample);
		addMorph: (action2 := self actionInspectReturnValue);
		yourself) -> { action1. action2 })
]

{ #category : #private }
GTExampleNautilusDualActionButton >> exampleStateToCache [
	^ {
		IconicButtonStateHolder forNautilus: result value first. 
		IconicButtonStateHolder forNautilus: result value second } 
]

{ #category : #private }
GTExampleNautilusDualActionButton >> inspectExample: aCompiledMethod [
	aCompiledMethod gtExample 
		ifNotNil: [ :example | example inspect ]
		ifNil: [ self notifyNoExample: aCompiledMethod ]
]

{ #category : #private }
GTExampleNautilusDualActionButton >> inspectReturnValue: aCompiledMethod [
	aCompiledMethod gtExample 
		ifNotNil: [ :example | 
			example result 
				ifNotNil: [ :exampleResult |
					exampleResult isSuccess 
						ifTrue: [ result returnValue inspect ]
						ifFalse: [ example debug ] ] ]
		ifNil: [ self notifyNoExample: aCompiledMethod ]
]

{ #category : #private }
GTExampleNautilusDualActionButton >> notifyNoExample: aCompiledMethod [
	GrowlMorph 
		openWithLabel: 'No valid example in'
		contents: aCompiledMethod gtDisplayString
]

{ #category : #private }
GTExampleNautilusDualActionButton >> privateActionIcon [
	^ self actions key
]
