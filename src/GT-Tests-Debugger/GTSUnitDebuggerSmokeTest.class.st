Class {
	#name : #GTSUnitDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-Tests-Debugger'
}

{ #category : #accessing }
GTSUnitDebuggerSmokeTest >> contextToTest [

	^ [ GTSUnitExampleFailingTest new testArrays ] asContext
]

{ #category : #accessing }
GTSUnitDebuggerSmokeTest >> debuggerToTest [

	^ GTSUnitDebugger
]

{ #category : #utils }
GTSUnitDebuggerSmokeTest >> stepToDebuggerEntryPointIn: aProcess [

	aProcess
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;	
		step;
		completeStep: aProcess suspendedContext; 
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		step
		
]
