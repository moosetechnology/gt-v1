Class {
	#name : #GTDebuggerRecorderOpenEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #'instance creation' }
GTDebuggerRecorderOpenEvent class >> fromDebugger: aDebugger [

	^ self new fromDebugger: aDebugger
]

{ #category : #initialization }
GTDebuggerRecorderOpenEvent >> fromDebugger: aDebugger [

	self infoAt: #debuggerClass put: aDebugger class name.
	self addWindowHashFor: aDebugger
]

{ #category : #initialization }
GTDebuggerRecorderOpenEvent >> initialize [
	super initialize.
	self initializeObfuscated.
]
