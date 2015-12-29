Class {
	#name : #GTDebuggerSmokeTest,
	#superclass : #TestCase,
	#instVars : [
		'session',
		'window',
		'debugger'
	],
	#category : #'GT-Tests-Debugger'
}

{ #category : #testing }
GTDebuggerSmokeTest class >> isAbstract [
	^ self name = #GTDebuggerSmokeTest
]

{ #category : #accessing }
GTDebuggerSmokeTest >> contextToTest [
	self subclassResponsibility
]

{ #category : #accessing }
GTDebuggerSmokeTest >> debuggerToTest [
	self subclassResponsability
]

{ #category : #accessing }
GTDebuggerSmokeTest >> instantiateSession [
	| context process |
	context := self contextToTest.

	process := Process 
		forContext: context
		priority: Processor userInterruptPriority.
	
	self stepToDebuggerEntryPointIn: process.
	^ self debuggerToTest spanNewSessionLabeled:  'test session' forContext: process suspendedContext fromProcess: process
]

{ #category : #running }
GTDebuggerSmokeTest >> setUp [
	session := self instantiateSession.
	debugger := self debuggerToTest new.
]

{ #category : #utils }
GTDebuggerSmokeTest >> stepToDebuggerEntryPointIn: aProcess [
	"Step into the execution until a context is reached 
	that can be handled by the debugger under test."
	
	^ self subclassResponsibility
]

{ #category : #running }
GTDebuggerSmokeTest >> tearDown [ 
	debugger ifNotNil: [ debugger close].
	window := nil.
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
