"
A GTStepIntoBytecodeDebugAction is debugging action for stepping into bytecode instructions representing message sends.

"
Class {
	#name : #GTStepIntoBytecodeDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-BytecodeDebugger'
}

{ #category : #registration }
GTStepIntoBytecodeDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousInto
]

{ #category : #testing }
GTStepIntoBytecodeDebugAction >> appliesToDebugger: aDebugger [

	^ aDebugger session isInterruptedContextPostMortem not
]

{ #category : #accessing }
GTStepIntoBytecodeDebugAction >> defaultLabel [

	^ 'Step into'
]

{ #category : #accessing }
GTStepIntoBytecodeDebugAction >> defaultOrder [

	^ 15
]

{ #category : #actions }
GTStepIntoBytecodeDebugAction >> executeAction [

	self session stepIntoBytecodeInContext: self currentContext
]

{ #category : #accessing }
GTStepIntoBytecodeDebugAction >> id [

	^ #GTStepIntoBytecodeDebugAction
]
