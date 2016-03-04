Class {
	#name : #GTDebuggerRecorderOpenEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTDebuggerRecorderOpenEvent >> fromDebugger: aDebugger [
	self infoAt: #debuggerClass put: aDebugger class name.
	self infoAt: #methodClass put: aDebugger currentContext methodClass name.
	self infoAt: #methodSelector put: aDebugger currentContext methodSelector.
	self infoAt: #pc put: aDebugger currentContext pc.
	changesContext := true.
	self addWindowHashFor: aDebugger
]
