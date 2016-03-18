Class {
	#name : #GTDebuggerRecorderChangeDebuggerEvent,
	#superclass : #GTDebuggerRecorderDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder'
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
