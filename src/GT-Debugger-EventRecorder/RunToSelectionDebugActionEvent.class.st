Class {
	#name : #RunToSelectionDebugActionEvent,
	#superclass : #GTDebuggerDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
RunToSelectionDebugActionEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	self infoAt: #selection put: aDebugAction debugger code getSelection.
]
