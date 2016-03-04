Class {
	#name : #GTDebuggerRecorderOpenEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
GTDebuggerRecorderOpenEvent >> fromDebugger: aDebugger [

	self infoAt: #debuggerClass put: aDebugger class name.
	self addWindowHashFor: aDebugger
]
