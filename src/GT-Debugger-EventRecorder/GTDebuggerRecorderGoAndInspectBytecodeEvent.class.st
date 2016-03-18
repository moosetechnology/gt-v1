"
I model the Go and Inspect debugging action in a GTBytecodeDebugger.

Corresponding debug action:
GTGoAndInspectBytecodeDebugAction
"
Class {
	#name : #GTDebuggerRecorderGoAndInspectBytecodeEvent,
	#superclass : #GTDebuggerRecorderDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #initialization }
GTDebuggerRecorderGoAndInspectBytecodeEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	self infoAt: #selection put: aDebugAction debugger bytecodePresentation selection.
]
