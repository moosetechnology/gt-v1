Class {
	#name : #GTGenericStackDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-Debugger-Tests'
}

{ #category : #accessing }
GTGenericStackDebuggerSmokeTest >> debuggerToTest [

	^ GTGenericStackDebugger
]

{ #category : #accessing }
GTGenericStackDebuggerSmokeTest >> instantiateSession [
	| context process |
	context := [ 20 factorial ] asContext.

	process := Process 
		forContext: context
		priority: Processor userInterruptPriority.
		
	^ self debuggerToTest spanNewSessionForContext: context fromProcess: process
]
