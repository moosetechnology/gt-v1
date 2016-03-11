Class {
	#name : #GTGlamourWrapperDebuggingActionEvent,
	#superclass : #GTDebuggerDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTGlamourWrapperDebuggingActionEvent >> fromDebugAction: aDebugAction [
	self flag: 'Find a better way to get type of action'.
	super fromDebugAction: aDebugAction.
	self infoAt: #glamourActionTitle put: aDebugAction asGlamourAction title.
]
