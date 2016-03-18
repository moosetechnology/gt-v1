Class {
	#name : #GTDebuggerRecorderGlamourWrapperEvent,
	#superclass : #GTDebuggerRecorderDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTDebuggerRecorderGlamourWrapperEvent >> fromDebugAction: aDebugAction [
	self flag: 'Find a better way to get type of action'.
	super fromDebugAction: aDebugAction.
	self infoAt: #glamourActionTitle put: aDebugAction asGlamourAction title.
]
