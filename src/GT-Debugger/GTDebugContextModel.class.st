"
GTDebugContextModel is a helper that complements the GTDebuggerModel. It is meant to be created dynamically for each selected method.

Instance Variables:
	context	<ContextPart>
	topContext	<ProtoObject>
	method	<CompiledMethod>
	methodNode	<MethodNode>
	ranges	<Dictionary>
"
Class {
	#name : #GTDebugContextModel,
	#superclass : #Object,
	#instVars : [
		'context',
		'topContext',
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
GTDebugContextModel class >> forContext: aContext [ 
	^ self new forContext: aContext 
]

{ #category : #'evaluating actions' }
GTDebugContextModel >> evaluate: expression [
	^ Compiler new
		evaluate: expression
		in: context
		to: context receiver
]

{ #category : #initialization }
GTDebugContextModel >> forContext: aContext [ 
	method := aContext method.
	methodNode := method methodNode.

	ranges := Dictionary new.
	
	" Put all ranges with a possitive Key PC in the ranges dictionary "
	methodNode rawSourceRanges
		keysAndValuesDo: [ :node :range |
			node pc = 0
				ifFalse: [ ranges at: node pc put: range ]].
			
	context := aContext.
	topContext := aContext.

	" Sort all the Key PCs in the sortedKeyPCs "
	"sortedKeyPCs := SortedCollection new."
	" ranges keysDo: [ :pc | sortedKeyPCs add: pc ]."
]

{ #category : #accessing }
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

{ #category : #private }
GTDebugContextModel >> locateClosureHome [
	"In case aContext is a BlockContext locate the closureHome and ask the
	user to validate the new context. If closureHome is not found or the user
	does not validate the new context, return nil.
	If aContext is not a BlockContext return aContext."
	| closureHome result aText |
	
	context isExecutingBlock ifTrue: [
		closureHome := context activeHome.
		closureHome ifNil: [
			self inform: 'Method for block not found on stack, can''t edit and continue'.
		 	^ nil].
		 (self confirm: 'I will have to revert to the method from\which this block originated.  Is that OK?' withCRs) 
			ifFalse: [^ nil].
		^ closureHome].
	
	^ context
]

{ #category : #accessing }
GTDebugContextModel >> receiver [
	^ context receiver
]

{ #category : #accessing }
GTDebugContextModel >> receiverClass [
	"Answer the class of the receiver. 
	It may differ from 'self selectedClass' "
	
	^ context receiver class
]

{ #category : #'evaluating actions' }
GTDebugContextModel >> recompileMethodTo: aText inContext: aContext [
	| classOfMethod selectedMessageName selector |
	
	classOfMethod := self selectedClassForContex: aContext.
	selectedMessageName := self selectedMessageNameForContext: aContext.
	
	selector := classOfMethod parserClass new parseSelector: aText.
	(selector == selectedMessageName or: [(selectedMessageName beginsWith: 'DoIt')
		and: [selector numArgs = selectedMessageName numArgs]]) ifFalse: [
			self inform: 'can''t change selector'. ^ nil].
		
	selector := classOfMethod compile: aText notifying: nil.
	selector isNil 
		ifFalse: [ ^ classOfMethod compiledMethodAt: selector. ]
		ifTrue: [ ^ nil ] 
		
]

{ #category : #accessing }
GTDebugContextModel >> selectedClass [
	
	^ self selectedClassForContex: context
]

{ #category : #accessing }
GTDebugContextModel >> selectedClassForContex: aContext [
	"Answer the class in which aContext's method was found."

	^ aContext methodClass
]

{ #category : #accessing }
GTDebugContextModel >> selectedMessageName [

	^ self selectedMessageNameForContext: context
]

{ #category : #accessing }
GTDebugContextModel >> selectedMessageNameForContext: aContext [
	"Answer the message selector of aContext.
	 If the method is unbound we can still usefully answer its old selector."

	| selector |
	selector := aContext methodSelector.
	^(selector ~~ aContext method selector
	    and: [selector beginsWith: 'DoIt'])
		ifTrue: [aContext method selector]
		ifFalse: [selector]
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

{ #category : #accessing }
GTDebugContextModel >> topContext: aContext [
	topContext  := aContext 
]
