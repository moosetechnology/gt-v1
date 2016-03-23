"
I model the wrapped glamour actions in a GTDebugger.

Corresponding debug action:
GTGlamourWrapperDebuggingAction
"
Class {
	#name : #GTDebuggerRecorderGlamourWrapperEvent,
	#superclass : #GTDebuggerRecorderDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #initialization }
GTDebuggerRecorderGlamourWrapperEvent >> fromDebugAction: aDebugAction [
	self flag: 'Find a better way to get type of action'.
	super fromDebugAction: aDebugAction.
	self infoAt: #glamourActionTitle put: aDebugAction asGlamourAction title.
]