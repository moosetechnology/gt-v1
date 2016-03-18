"
I model the Step to bytecode debugging action in a GTBytecodeDebugger.

Corresponding debug action:
GTStepToBytecodeDebugAction
"
Class {
	#name : #GTDebuggerRecorderStepToBytecodeEvent,
	#superclass : #GTDebuggerRecorderDebugActionEvent,
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #initialization }
GTDebuggerRecorderStepToBytecodeEvent >> fromDebugAction: aDebugAction [
	super fromDebugAction: aDebugAction.
	self infoAt: #selection put: aDebugAction debugger bytecodePresentation selection.
]
