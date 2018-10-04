"
This models the debugger. It contains the current context and process. Its main goal is to handle debugger actions such as restart or stepInto. It is the model used as an input to GTDebugger.

Instance Variables:
	context	<ContextPart>
	process	<Process>
"
Class {
	#name : #GTDebuggerSession,
	#superclass : #Object,
	#instVars : [
		'context',
		'process'
	],
	#category : #'GT-DebuggerModel'
}

{ #category : #'instance creation' }
GTDebuggerSession class >> process: aProcess context: aContext [
	^ self new
		process: aProcess context: aContext
]

{ #category : #'private process' }
GTDebuggerSession >> activePC: aContext [
	^ (self isLatestContext: aContext)
		ifTrue: [ context pc ]
		ifFalse: [ self previousPC: aContext ].
]

{ #category : #private }
GTDebuggerSession >> clear [
	process := nil.
	context := nil
]

{ #category : #accessing }
GTDebuggerSession >> context [
	^ context
]

{ #category : #accessing }
GTDebuggerSession >> createModelForContext: aContext [
	^ (GTDebugContext forContext: aContext) topContext: context
]

{ #category : #'private context' }
GTDebuggerSession >> currentCodeRange: aContext [
	^(self createModelForContext: aContext) sourceRangeForPC: (self activePC: aContext)
]

{ #category : #'private context' }
GTDebuggerSession >> filterTopContext: aContext [
	|ctx|
	 
	ctx := aContext.
	(self shouldDisplayOnTopContext: ctx) ifTrue: [^ ctx].
	[(ctx := ctx sender) ~~ nil] whileTrue:
		[(self shouldDisplayOnTopContext: ctx) ifTrue: [^ ctx]].
	^ nil
]

{ #category : #'private process' }
GTDebuggerSession >> isLatestContext: aContext [
	^ process suspendedContext == aContext
]

{ #category : #'private context' }
GTDebuggerSession >> previousPC: aContext [
	^ (aContext method pcPreviousTo: aContext pc)
		ifNil: [ aContext pc ]
]

{ #category : #accessing }
GTDebuggerSession >> process [
	^ process
]

{ #category : #initialization }
GTDebuggerSession >> process: aProcess context: aContext [
	aProcess stepToSendOrReturn.
	process := aProcess.
	context := self filterTopContext: aContext.
	context isNil ifTrue: [context := aContext].
	

]

{ #category : #'evaluating actions' }
GTDebuggerSession >> recompileMethodTo: text inContext: recompilationContext [
	| newMethod |				
				
	newMethod := (self createModelForContext: recompilationContext) recompileCurrentMethodTo: text.
	newMethod isNil 
		ifFalse: [ 
			self rewindContextToMethod: newMethod fromContext: recompilationContext. 
			^ newMethod ] 
		ifTrue: [
			^ nil ]
]

{ #category : #'debugging actions' }
GTDebuggerSession >> restart: selectedContext [
	self unwindTo: selectedContext.
	process
		restartTop;
		stepToSendOrReturn.
	
	self triggerEvent: #restart		
	
]

{ #category : #'debugging actions' }
GTDebuggerSession >> resume [
	process resume.
	
	self triggerEvent: #resume
]

{ #category : #updating }
GTDebuggerSession >> rewindContextToMethod: aMethod fromContext: aContext [
	"this method is typically to be used after a hot compilation of a method from the stack"
	| ctxt |
	ctxt :=  process popTo: aContext.
	
	ctxt == aContext
		ifFalse: [
			self inform: 'Method saved, but current context unchanged\because of unwind error. Click OK to see error' withCRs]
		ifTrue: [
			process
				restartTopWith: aMethod;
				stepToSendOrReturn ].
	
	self flag: 'is it realy necessary to handle quick methods separately?'.
	
	^ context := ctxt
]

{ #category : #accessing }
GTDebuggerSession >> selectedCodeRange: selectedContext [
	^ self currentCodeRange: selectedContext
]

{ #category : #'private context' }
GTDebuggerSession >> shouldDisplayOnTopContext: aContext [
	
	^ aContext method selector ~= #halt
]

{ #category : #accessing }
GTDebuggerSession >> stack [
	^ context stack
]

{ #category : #accessing }
GTDebuggerSession >> stackOfSize: size [
	^ context stackOfSize: size
]

{ #category : #'debugging actions' }
GTDebuggerSession >> stepInto [
	self stepInto: context
]

{ #category : #'debugging actions' }
GTDebuggerSession >> stepInto: selectedContext [
	context := process step: selectedContext.
	process stepToSendOrReturn.
	
	self triggerEvent: #stepInto
]

{ #category : #'debugging actions' }
GTDebuggerSession >> stepOver [
	self stepOver: context
]

{ #category : #'debugging actions' }
GTDebuggerSession >> stepOver: selectedContext [
	| newContext |
	newContext := process completeStep: selectedContext.
	context := 
		newContext == selectedContext
			ifTrue: [ process stepToSendOrReturn ]
			ifFalse: [ newContext ].

	self triggerEvent: #stepOver 
]

{ #category : #'debugging actions' }
GTDebuggerSession >> stepThrough [
	self stepThrough: context
]

{ #category : #'debugging actions' }
GTDebuggerSession >> stepThrough: selectedContext [
	"Send messages until you return to the present method context.
	 Used to step into a block in the method."
	
	context := process stepToHome: selectedContext.
	process stepToSendOrReturn.
			
	self triggerEvent: #stepThrough 
]

{ #category : #'debugging actions' }
GTDebuggerSession >> terminate [
	self process isNil ifFalse: [self process terminate].
	self clear.
	
	self triggerEvent: #terminate
]

{ #category : #private }
GTDebuggerSession >> unwindTo: aContext [
	|ctx|
	ctx := process popTo: aContext.
	ctx == aContext ifFalse: [ self error: 'Could not unwind stack' ].
	context := aContext
]

{ #category : #updating }
GTDebuggerSession >> updateWithContext: newContext fromProcess: aProcess [
	self process: aProcess context: newContext
	 
	"self process: aProcess.
	self unwindTo: (self filterTopContextAndUnwindForContext: newContext).
	self process stepToSendOrReturn."
]
