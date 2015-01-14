Class {
	#name : #GTStepToBytecodeDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-BytecodeDebugger'
}

{ #category : #registration }
GTStepToBytecodeDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtContextBytecodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousPlay
]

{ #category : #testing }
GTStepToBytecodeDebugAction >> appliesToDebugger: aDebugger [

	^ aDebugger session isInterruptedContextPostMortem not and: [ 
		aDebugger codePresentation selection offset > aDebugger currentContext pc ]
]

{ #category : #accessing }
GTStepToBytecodeDebugAction >> defaultLabel [

	^ 'Step to bytecode'
]

{ #category : #accessing }
GTStepToBytecodeDebugAction >> defaultOrder [

	^ 10
]

{ #category : #actions }
GTStepToBytecodeDebugAction >> executeAction [

	self session
		runToBytecode: self debugger codePresentation selection 
		inContext: self currentContext
]

{ #category : #accessing }
GTStepToBytecodeDebugAction >> id [

	^ GTStepToBytecodeDebugAction name
]
