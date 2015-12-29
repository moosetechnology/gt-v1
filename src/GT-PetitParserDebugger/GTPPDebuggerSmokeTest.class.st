Class {
	#name : #GTPPDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #accessing }
GTPPDebuggerSmokeTest >> contextToTest [

	^ [ PPArithmeticParser new parse: '1+1'] asContext
]

{ #category : #accessing }
GTPPDebuggerSmokeTest >> debuggerToTest [

	^ GTPPDebugger
]

{ #category : #testing }
GTPPDebuggerSmokeTest >> expectedFailures [
	^ #(testDebugger)
]

{ #category : #utils }
GTPPDebuggerSmokeTest >> stepToDebuggerEntryPointIn: aProcess [
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
