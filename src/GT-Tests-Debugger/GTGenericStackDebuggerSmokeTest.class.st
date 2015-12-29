Class {
	#name : #GTGenericStackDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-Tests-Debugger'
}

{ #category : #accessing }
GTGenericStackDebuggerSmokeTest >> contextToTest [

	^ [ 20 factorial ] asContext
]

{ #category : #accessing }
GTGenericStackDebuggerSmokeTest >> debuggerToTest [

	^ GTGenericStackDebugger
]

{ #category : #utils }
GTGenericStackDebuggerSmokeTest >> stepToDebuggerEntryPointIn: aProcess [
	"The generic debugger can handle any context."
]
