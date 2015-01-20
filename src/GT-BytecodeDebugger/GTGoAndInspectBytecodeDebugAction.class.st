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
	<gtContextBytecodeCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #'as yet unclassified' }
GTGoAndInspectBytecodeDebugAction >> defaultKeyText [

	^ 'g'
]

{ #category : #accessing }
GTGoAndInspectBytecodeDebugAction >> defaultLabel [

	^ 'Go and inspect'
]

{ #category : #actions }
GTGoAndInspectBytecodeDebugAction >> executeAction [
	
	self debugger inspect: self debugger bytecodePresentation selection  
		

]

{ #category : #accessing }
GTGoAndInspectBytecodeDebugAction >> id [

	^ GTGoAndInspectBytecodeDebugAction name
]

{ #category : #initialization }
GTGoAndInspectBytecodeDebugAction >> initialize [

	super initialize.
	self needsUpdate: false
]
