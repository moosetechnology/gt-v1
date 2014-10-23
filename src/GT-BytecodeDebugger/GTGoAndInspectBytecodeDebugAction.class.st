"
GTGoAndInspectBytecodeDebugAction class is a debugging action that opens the currently selected bytecode in the inspector embeded within the debugger.

"
Class {
	#name : #GTGoAndInspectBytecodeDebugAction,
	#superclass : #DebugAction,
	#category : #'GT-BytecodeDebugger'
}

{ #category : #'as yet unclassified' }
GTGoAndInspectBytecodeDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtContextBytecodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #accessing }
GTGoAndInspectBytecodeDebugAction >> defaultLabel [

	^ 'Go and inspect'
]

{ #category : #actions }
GTGoAndInspectBytecodeDebugAction >> executeAction [
	
	self debugger inspect: self debugger codePresentation selection  
		

]

{ #category : #accessing }
GTGoAndInspectBytecodeDebugAction >> id [

	^ GTGoAndInspectBytecodeDebugAction name
]

{ #category : #'as yet unclassified' }
GTGoAndInspectBytecodeDebugAction >> initialize [

	super initialize.
	self needsUpdate: false
]
