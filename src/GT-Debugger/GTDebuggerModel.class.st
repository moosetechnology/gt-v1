Class {
	#name : #GTDebuggerModel,
	#superclass : #Object,
	#instVars : [
		'context',
		'process'
	],
	#category : #'GT-Debugger'
}

{ #category : #'instance creation' }
GTDebuggerModel class >> process: aProcess [
	^ self new
		process: aProcess
]

{ #category : #'private process' }
GTDebuggerModel >> activePC: aContext [
	^ (self isLatestContext: aContext)
		ifTrue: [ context pc ]
		ifFalse: [ self previousPC: aContext ].
]

{ #category : #accessing }
GTDebuggerModel >> context [
	^ context
]

{ #category : #accessing }
GTDebuggerModel >> contextVariableValuePairList: aContext [
	"Return a collection of 'temporary variables name -> value' for the received context"
	|fieldList|
	
	fieldList := OrderedCollection new.
	fieldList add: ('thisContext' -> aContext ).
	
	aContext == nil ifTrue: [^fieldList].
	
	fieldList 
		add: ('stack top' -> (aContext stackPtr > 0 ifTrue: [aContext top]));
		add: ('all temp vars' -> aContext tempsAndValues).
	(aContext tempNames size > 0) ifTrue: [
		fieldList addAll: ((1 to: aContext tempNames size) collect: [ :index | 
			(aContext tempNames at: index ) -> (aContext debuggerMap namedTempAt: index in: aContext ) ] ) ].
		
	^ fieldList
					
]

{ #category : #'private context' }
GTDebuggerModel >> currentCodeRange: aContext [
	^(self methodModel: aContext) sourceRangeForPC: (self activePC: aContext)
]

{ #category : #'evaluating actions' }
GTDebuggerModel >> evaluate: expression in: aContext [
	^ Compiler new
		evaluate: expression
		in: aContext
		to: aContext receiver
]

{ #category : #'private process' }
GTDebuggerModel >> isLatestContext: aContext [
	^ process suspendedContext == aContext
]

{ #category : #'private context' }
GTDebuggerModel >> methodModel: aContext [
	^ GTDebugMethodModel forMethod: aContext method
]

{ #category : #'private context' }
GTDebuggerModel >> previousPC: aContext [
	^ (aContext method pcPreviousTo: aContext pc)
		ifNil: [ aContext pc ]
]

{ #category : #accessing }
GTDebuggerModel >> process [
	^ process
]

{ #category : #accessing }
GTDebuggerModel >> process: aProcess [
	aProcess stepToSendOrReturn.
	context := aProcess suspendedContext.
	process := aProcess
]

{ #category : #'private context' }
GTDebuggerModel >> receiverClass: aContext [
	^ aContext receiver class
]

{ #category : #accessing }
GTDebuggerModel >> receiverVariableValuePairList: aContext [
	"Return a collection of 'variable name -> value' for the receiver of the given context"
	|receiver fieldList|
	
	receiver := aContext receiver.
	
	fieldList := OrderedCollection new.
	fieldList 
		add: ('self' -> receiver);
		add: ('all inst vars' -> (receiver longPrintStringLimitedTo: 20000)).	
	fieldList addAll: (receiver class allInstVarNames collect: [:each | each -> (receiver instVarNamed: each) ]).

	receiver class isVariable ifTrue: [
		(1 to: receiver basicSize) collect: [:index | index -> (receiver instVarAt: index)  ]].
	
	^ fieldList
					
]

{ #category : #'debugging actions' }
GTDebuggerModel >> restart: selectedContext [
	self unwindTo: selectedContext.
	process
		restartTop;
		stepToSendOrReturn
]

{ #category : #'debugging actions' }
GTDebuggerModel >> resume [
	process resume
]

{ #category : #accessing }
GTDebuggerModel >> selectedCodeRange: selectedContext [
	^ self currentCodeRange: selectedContext
]

{ #category : #accessing }
GTDebuggerModel >> stack [
	^ context stack
]

{ #category : #accessing }
GTDebuggerModel >> stackOfSize: size [
	^ context stackOfSize: size
]

{ #category : #'debugging actions' }
GTDebuggerModel >> stepInto [
	self stepInto: context
]

{ #category : #'debugging actions' }
GTDebuggerModel >> stepInto: selectedContext [
	context := process step: selectedContext.
	process stepToSendOrReturn.
]

{ #category : #'debugging actions' }
GTDebuggerModel >> stepOver [
	self stepOver: context
]

{ #category : #'debugging actions' }
GTDebuggerModel >> stepOver: selectedContext [
	| newContext |
	newContext := process completeStep: selectedContext.
	context := 
		newContext == selectedContext
			ifTrue: [ process stepToSendOrReturn ]
			ifFalse: [ selectedContext ]
]

{ #category : #'debugging actions' }
GTDebuggerModel >> stepThrough [
	self stepThrough: context
]

{ #category : #'debugging actions' }
GTDebuggerModel >> stepThrough: selectedContext [
	"Send messages until you return to the present method context.
	 Used to step into a block in the method."
	self halt.
	context := process stepToHome: selectedContext.
	process stepToSendOrReturn.
]

{ #category : #private }
GTDebuggerModel >> unwindTo: aContext [
	|ctx|
	ctx := process popTo: aContext.
	ctx == aContext ifFalse: [ self error: 'Could not unwind stack' ].
	context := aContext
]
