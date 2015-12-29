Class {
	#name : #GTBytecodeDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-Tests-Debugger'
}

{ #category : #accessing }
GTBytecodeDebuggerSmokeTest >> contextToTest [

	^ [ 20 factorial ] asContext
]

{ #category : #accessing }
GTBytecodeDebuggerSmokeTest >> debuggerToTest [

	^ GTBytecodeDebugger
]

{ #category : #utils }
GTBytecodeDebuggerSmokeTest >> stepToDebuggerEntryPointIn: aProcess [
	"The bytecode debugger can handle any context."
]
