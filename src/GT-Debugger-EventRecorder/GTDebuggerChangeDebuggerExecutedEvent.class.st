Class {
	#name : #GTDebuggerChangeDebuggerExecutedEvent,
	#superclass : #GTDebuggerDebugActionExecutedEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #private }
GTDebuggerChangeDebuggerExecutedEvent >> addNewWindowHashFor: aPresentation [

	aPresentation window ifNotNil: [ :aWindow |
		self infoAt: #newWindowHash put: aWindow identityHash ]
]

{ #category : #initialization }
GTDebuggerChangeDebuggerExecutedEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	self isExecuted ifTrue: [ self addNewWindowHashFor: aDebugAction newDebugger ]
]
