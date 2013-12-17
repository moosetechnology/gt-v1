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

{ #category : #accessing }
GTDebuggerSmokeTest >> debuggerToTest [
	self subclassResponsability
]

{ #category : #accessing }
GTDebuggerSmokeTest >> instantiateSession [
	self subclassResponsability
]

{ #category : #running }
GTDebuggerSmokeTest >> setUp [
	session := self instantiateSession.
	debugger := self debuggerToTest new.
]

{ #category : #running }
GTDebuggerSmokeTest >> tearDown [ 
	debugger close
]

{ #category : #tests }
GTDebuggerSmokeTest >> testDebugger [

	self assert: (debugger class handlesContext: session interruptedContext). 

	window := debugger openOn: session.
	
	self assert: window model equals: debugger.
	self assert: debugger session interruptedContext notNil.
	self assert: debugger session interruptedProcess notNil.
	
 	debugger close.

	self assert: window model equals: nil.
	self assert: debugger session interruptedContext equals: nil.
	self assert: debugger session interruptedProcess equals: nil.
]
