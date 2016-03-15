Class {
	#name : #GTDebuggerChangeDebuggerEvent,
	#superclass : #GTDebuggerDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #private }
GTDebuggerChangeDebuggerEvent >> addNewWindowHashFor: aPresentation [

	aPresentation window ifNotNil: [ :aWindow |
		self infoAt: #newWindowHash put: aWindow identityHash ]
]

{ #category : #initialization }
GTDebuggerChangeDebuggerEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	aDebugAction newDebugger isNotNil ifTrue: [ self addNewWindowHashFor: aDebugAction newDebugger ]
]