Class {
	#name : #GTDebuggerDebugActionEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTDebuggerDebugActionEvent >> asDebugActionFor: aDebugger [
	^ (info at: #debugActionClass) asSymbol asClass gtGlobalDebuggingActionFor: aDebugger.
]

{ #category : #initialization }
GTDebuggerDebugActionEvent >> fromDebugAction: aDebugAction [
	self infoAt: #debugActionClass put: aDebugAction class name.
	"self addWindowHashFor: aDebugAction debugger"
	
]
