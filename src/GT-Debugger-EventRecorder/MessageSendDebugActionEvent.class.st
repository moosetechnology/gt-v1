Class {
	#name : #MessageSendDebugActionEvent,
	#superclass : #GTDebuggerDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
MessageSendDebugActionEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	self infoAt: #selector put: aDebugAction selector.
]
