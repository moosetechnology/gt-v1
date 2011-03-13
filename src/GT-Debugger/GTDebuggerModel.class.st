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

{ #category : #private }
GTDebuggerModel >> unwindTo: aContext [
	|ctx|
	ctx := process popTo: aContext.
	ctx == aContext ifFalse: [ self error: 'Could not unwind stack' ].
	context := aContext
]
