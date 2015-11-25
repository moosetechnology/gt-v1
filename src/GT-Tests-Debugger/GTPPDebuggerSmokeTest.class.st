Class {
	#name : #GTPPDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-Tests-Debugger'
}

{ #category : #accessing }
GTPPDebuggerSmokeTest >> debuggerToTest [

	^ GTPPDebugger
]

{ #category : #accessing }
GTPPDebuggerSmokeTest >> expectedFailures [
	^ #(testDebugger)
]

{ #category : #accessing }
GTPPDebuggerSmokeTest >> instantiateSession [
	| initialContext process |
	initialContext := [ PPArithmeticParser new parse: '1+1'] asContext.
	process := Process 
		forContext: initialContext
		priority: Processor userInterruptPriority.
		
	self stepToWhenParsingStartsInProcess: process.	
	^ self debuggerToTest spanNewSessionLabeled:  'test session' forContext: process suspendedContext fromProcess: process
]

{ #category : #private }
GTPPDebuggerSmokeTest >> stepToWhenParsingStartsInProcess: aProcess [
	"Step through the execution until the process reaches a context 
	that can be handles using the PetitParser debugger"
	
	aProcess 
		step;
		step;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		step;
		step;
		step; "send the message 'parse:' "
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		step. "send the message parseOn: "
	aProcess stepToSendOrReturn
]
