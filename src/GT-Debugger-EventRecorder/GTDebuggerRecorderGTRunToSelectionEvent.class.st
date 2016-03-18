"
I model the Run To Selection debugging action in a GTDebugger.

Corresponding debug action:
GTRunToSelectionDebugAction
"
Class {
	#name : #GTDebuggerRecorderGTRunToSelectionEvent,
	#superclass : #GTDebuggerRecorderDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #initialization }
GTDebuggerRecorderGTRunToSelectionEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	self infoAt: #selection put: aDebugAction debugger selectionInterval.
]
