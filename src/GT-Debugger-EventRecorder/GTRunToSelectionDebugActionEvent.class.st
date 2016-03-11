Class {
	#name : #GTRunToSelectionDebugActionEvent,
	#superclass : #GTDebuggerDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTRunToSelectionDebugActionEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	self infoAt: #selection put: aDebugAction debugger selectionInterval.
]
