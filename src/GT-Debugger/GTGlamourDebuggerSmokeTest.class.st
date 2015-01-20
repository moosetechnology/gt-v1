Class {
	#name : #GTGlamourDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-Debugger-Tests'
}

{ #category : #accessing }
GTGlamourDebuggerSmokeTest >> debuggerToTest [

	^ GTGlamourDebugger
]

{ #category : #accessing }
GTGlamourDebuggerSmokeTest >> instantiateSession [
	| initialContext process |
	initialContext := [GLMBasicExamples open] asContext.
	process := Process 
		forContext: initialContext
		priority: Processor userInterruptPriority.
		
	self stepToGlamourModelConstructionInProcess: process.	
	^ self debuggerToTest spanNewSessionForContext: process suspendedContext fromProcess: process
]

{ #category : #private }
GTGlamourDebuggerSmokeTest >> stepToGlamourModelConstructionInProcess: aProcess [

	aProcess
		step;
		step;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		step; "send openOn:"
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		step; "send openOn:with:"
		completeStep: aProcess suspendedContext;
		completeStep: aProcess suspendedContext;
		step "send startOn:"
]
