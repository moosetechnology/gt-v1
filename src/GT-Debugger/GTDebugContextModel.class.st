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

{ #category : #accessing }
GTDebugContextModel >> locateClosureHome [
	"In case the current context is a BlockContext locate the closureHome and ask the
	user to validate the new context. If closureHome is not found or the user does not 
	validate the new context, return nil. 
	If the current context is not a BlockContext return it."
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
GTDebugContextModel >> recompileCurrentMethodTo: aText [ 
	| classOfMethod selector |
	
	classOfMethod := self selectedClass.
	selector := classOfMethod parserClass new parseSelector: aText.
	(selector == self selectedMessageName or: [(self selectedMessageName beginsWith: 'DoIt')
		and: [selector numArgs = self selectedMessageName numArgs]]) ifFalse: [
			self inform: 'can''t change selector'. ^ nil].
		
	selector := classOfMethod 
		compile: aText 
		classified: self selectedMessageCategoryName 
		notifying: nil.
	selector isNil 
		ifFalse: [ ^ classOfMethod compiledMethodAt: selector. ]
		ifTrue: [ ^ nil ] 
		
]

{ #category : #accessing }
GTDebugContextModel >> selectedClass [
	"Answer the class in which the current context's method was found."

	^ context methodClass
]

{ #category : #accessing }
GTDebugContextModel >> selectedMessageCategoryName [
	"Answer the name of the message category of the message of the current context."

	^ self selectedClass organization categoryOfElement: self selectedMessageName
]

{ #category : #accessing }
GTDebugContextModel >> selectedMessageName [
	"Answer the message selector of the current context.
	 If the method is unbound we can still usefully answer its old selector."

	| selector |
	selector := context methodSelector.
	^(selector ~~ context method selector
	    and: [selector beginsWith: 'DoIt'])
		ifTrue: [context method selector]
		ifFalse: [selector]
]

{ #category : #private }
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
