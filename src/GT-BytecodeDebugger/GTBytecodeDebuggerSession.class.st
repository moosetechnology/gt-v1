"
A GTBytecodeDebuggerSession provides debugging actions at the level of the bytecode

"
Class {
	#name : #GTBytecodeDebuggerSession,
	#superclass : #DebugSession,
	#category : #'GT-BytecodeDebugger'
}

{ #category : #'debugging actions' }
GTBytecodeDebuggerSession >> stepIntoBytecodeInContext: aContext [

	(self isContextPostMortem: aContext) ifTrue: [^ self].

	interruptedProcess step: aContext.
	self updateContextTo:  interruptedProcess suspendedContext.
]

{ #category : #'debugging actions' }
GTBytecodeDebuggerSession >> stepOverBytecodeInContext: aContext [
	| newContext |
	
	(self isContextPostMortem: aContext) ifTrue: [^ self].

	newContext := interruptedProcess completeStep: aContext.
	self updateContextTo:  
		(newContext == aContext
			ifTrue: [ interruptedProcess suspendedContext ]
			ifFalse: [ newContext ]).
]

{ #category : #acessing }
GTBytecodeDebuggerSession >> symbolicBytecodeForCurrentPCFrom: aContext [
	| pc |
	
	pc := aContext pc.
	^ aContext method symbolicBytecodes 
		detect: [ :each | each offset = pc ]
		ifNone: [ nil ]
]
