"
A GTStepOverBytecodeDebugAction is a debugging actions that provides the ability to step over a bytecode instruction.

"
Class {
	#name : #GTStepOverBytecodeDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-BytecodeDebugger'
}

{ #category : #registration }
GTStepOverBytecodeDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousOver
]

{ #category : #testing }
GTStepOverBytecodeDebugAction >> appliesToDebugger: aDebugger [

	^ aDebugger session isInterruptedContextPostMortem not
]

{ #category : #accessing }
GTStepOverBytecodeDebugAction >> defaultLabel [

	^ 'Step over bytecode'
]

{ #category : #accessing }
GTStepOverBytecodeDebugAction >> defaultOrder [

	^ 20
]

{ #category : #actions }
GTStepOverBytecodeDebugAction >> executeAction [

	self session stepOverBytecodeInContext: self currentContext
]

{ #category : #accessing }
GTStepOverBytecodeDebugAction >> id [

	^ GTStepOverBytecodeDebugAction name
]
