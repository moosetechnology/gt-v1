Class {
	#name : #GTGenericStackDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-Debugger-Tests'
}

{ #category : #'as yet unclassified' }
GTGenericStackDebuggerSmokeTest >> debuggerToTest [

	^ GTDebugger
]

{ #category : #'as yet unclassified' }
GTGenericStackDebuggerSmokeTest >> instantiateSession [
	| context process |
	context := [ 20 factorial ] asContext.

	process := Process 
		forContext: context
		priority: Processor userInterruptPriority.
		
	^ self debuggerToTest spanNewSessionForContext: context fromProcess: process
]
