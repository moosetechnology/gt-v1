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

{ #category : #private }
GTDebuggerModel >> clear [
	process := nil.
	context := nil.
]

{ #category : #accessing }
GTDebuggerModel >> context [
	^ context
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

{ #category : #'as yet unclassified' }
GTDebuggerModel >> gtInspectorPresentationsInText: composite [
	"Add all the presentation belonging to the current context and its receiver"
	|objectPresentation contextPresentation|
	
	"this does not work"
	"self context gtInspectorPresentationsIn: composite.
	self context receiver gtInspectorPresentationsIn: composite"
	
	"this also does not work"
	contextPresentation := GLMCompositePresentation new.
	contextPresentation title: [self context class printString].
	self context gtInspectorPresentationsIn: contextPresentation.
	composite custom: (contextPresentation startOn: self context).
	
	objectPresentation := GLMCompositePresentation new.
	objectPresentation title: [self context receiver class printString].
	self context receiver gtInspectorPresentationsIn: objectPresentation.
	composite 
		custom: (objectPresentation startOn: self context receiver);
		display: [:anObject | self context receiver].
	
	
	
]

{ #category : #'as yet unclassified' }
GTDebuggerModel >> gtInspectorRetrieveVariableValuePairs [
	|fieldList|

	fieldList := OrderedCollection new.
	fieldList 
		add: ('self' -> self context receiver).
		"add: ('all inst vars' -> (self context receiver longPrintStringLimitedTo: 20000)).	"

	fieldList add: ('thisContext' -> self context).
	self context == nil ifTrue: [^fieldList].
	fieldList 
		add: ('stack top' -> (self context stackPtr > 0 ifTrue: [self context top])).
		"add: ('all temp vars' -> self context tempsAndValues)."
		
	^ fieldList
]

{ #category : #'private process' }
GTDebuggerModel >> isLatestContext: aContext [
	^ process suspendedContext == aContext
]

{ #category : #'private context' }
GTDebuggerModel >> methodModel: aContext [
	^ GTDebugContextModel forContext: aContext fromProcess: process
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

{ #category : #'debugging actions' }
GTDebuggerModel >> restart: selectedContext [
	self unwindTo: selectedContext.
	process
		restartTop;
		stepToSendOrReturn
]

{ #category : #'debugging actions' }
GTDebuggerModel >> resume [
	process resume.
	self clear.
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

{ #category : #'debugging actions' }
GTDebuggerModel >> terminate [
	self process isNil ifFalse: [self process terminate].
	self clear.
]

{ #category : #private }
GTDebuggerModel >> unwindTo: aContext [
	|ctx|
	ctx := process popTo: aContext.
	ctx == aContext ifFalse: [ self error: 'Could not unwind stack' ].
	context := aContext
]
