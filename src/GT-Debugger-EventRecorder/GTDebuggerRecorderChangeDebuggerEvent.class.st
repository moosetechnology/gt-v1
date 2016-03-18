"
I model the debugging action of changing the debugger (e.g. stack debugger <-> bytecode debugger).

Corresponding debug action:
GTChangeDebuggerAction
"
Class {
	#name : #GTDebuggerRecorderChangeDebuggerEvent,
	#superclass : #GTDebuggerRecorderDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #private }
GTDebuggerRecorderChangeDebuggerEvent >> addNewWindowHashFor: aPresentation [

	aPresentation window ifNotNil: [ :aWindow |
		self infoAt: #newWindowHash put: aWindow identityHash ]
]

{ #category : #initialization }
GTDebuggerRecorderChangeDebuggerEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	aDebugAction newDebugger isNotNil ifTrue: [ self addNewWindowHashFor: aDebugAction newDebugger ]
]
