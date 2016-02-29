Class {
	#name : #GTDebuggerRecorderOpenEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #'as yet unclassified' }
GTDebuggerRecorderOpenEvent >> fromDebugger: aDebugger [

	self infoAt: #debuggerClass put: aDebugger class name.
	self addWindowHashFor: aDebugger
]
