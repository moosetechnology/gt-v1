Class {
	#name : #GTDebuggerSmokeTest,
	#superclass : #TestCase,
	#instVars : [
		'session',
		'window',
		'debugger'
	],
	#category : #'GT-Debugger-Tests'
}

{ #category : #testing }
GTDebuggerSmokeTest class >> isAbstract [
	^ self name = #GTDebuggerSmokeTest
]

{ #category : #'as yet unclassified' }
GTDebuggerSmokeTest >> debuggerToTest [
	self subclassResponsability
]

{ #category : #'as yet unclassified' }
GTDebuggerSmokeTest >> instantiateSession [
	self subclassResponsability
]

{ #category : #'as yet unclassified' }
GTDebuggerSmokeTest >> setUp [
	session := self instantiateSession 
]

{ #category : #'as yet unclassified' }
GTDebuggerSmokeTest >> tearDown [ 
	debugger close
]

{ #category : #'as yet unclassified' }
GTDebuggerSmokeTest >> testDebugger [

	debugger := self debuggerToTest new.
	window := debugger openOn: session.
	
	self assert: window model equals: debugger.
	
 	debugger close.
	
	self assert: window model equals: nil.
]
