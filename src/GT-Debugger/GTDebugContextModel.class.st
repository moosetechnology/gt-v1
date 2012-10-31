Class {
	#name : #GTDebugContextModel,
	#superclass : #Object,
	#instVars : [
		'context',
		'latestContext',
		'method',
		'methodNode',
		'ranges'
	],
	#classVars : [
		'MapCache',
		'MapCacheEntries'
	],
	#category : #'GT-Debugger'
}

{ #category : #'instance creation' }
GTDebugContextModel class >> forContext: aContext fromProcess: aProcess [
	^ self new forContext: aContext fromProcess: aProcess
]

{ #category : #'evaluating actions' }
GTDebugContextModel >> evaluate: expression [
	^ Compiler new
		evaluate: expression
		in: context
		to: context receiver
]

{ #category : #'instance creation' }
GTDebugContextModel >> forContext: aContext fromProcess: aProcess [
	method := aContext method.
	methodNode := method methodNode.

	ranges := Dictionary new.
	
	" Put all ranges with a possitive Key PC in the ranges dictionary "
	methodNode rawSourceRanges
		keysAndValuesDo: [ :node :range |
			node pc = 0
				ifFalse: [ ranges at: node pc put: range ]].
			
	context := aContext.
	latestContext := aProcess suspendedContext 

	" Sort all the Key PCs in the sortedKeyPCs "
	"sortedKeyPCs := SortedCollection new."
	" ranges keysDo: [ :pc | sortedKeyPCs add: pc ]."
]

{ #category : #'as yet unclassified' }
GTDebugContextModel >> gtDebuggerRetrieveVariableValuePairs [
	|fieldList|

	fieldList := OrderedCollection new.
	fieldList 
		add: ('_self' ->  context receiver);
	      addAll: (context receiver class allInstVarNames collect: [:each | each -> (context receiver instVarNamed: each) ]).
	
	fieldList add: ('_thisContext' ->  context).
	 context == nil ifTrue: [^fieldList].
	fieldList 
		add: ('_stack top' -> ( context stackPtr > 0 ifTrue: [ context top])).
		
	(context tempNames size > 0) ifTrue: [
		fieldList addAll: ((1 to: context tempNames size) collect: [ :index | 
			(context tempNames at: index ) -> (context debuggerMap namedTempAt: index in: context ) ] ) ].
	
	^ fieldList
]

{ #category : #accessing }
GTDebugContextModel >> receiver [
	^ context receiver
]

{ #category : #accessing }
GTDebugContextModel >> receiverClass [
	^ context receiver class
]

{ #category : #accessing }
GTDebugContextModel >> source [
	^ method holdsTempNames
		ifTrue: [ method getSource ]
		ifFalse: [ methodNode sourceText ]
]

{ #category : #accessing }
GTDebugContextModel >> sourceRangeForPC: pc [
	^ ranges at: pc ifAbsent: [ ^ 1 to: 0 ].
]

{ #category : #accessing }
GTDebugContextModel >> sourceText [
	^ self source asText
]
