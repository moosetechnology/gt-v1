Class {
	#name : #GTGlamourWrapperDebuggingActionEvent,
	#superclass : #GTDebuggerDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTGlamourWrapperDebuggingActionEvent >> fromDebugAction: aDebugAction [
	self flag: 'Find a way to get type of action'.
	super fromDebugAction: aDebugAction.
	"self infoAt: #debugActionClass put: aDebugAction class name."
]
