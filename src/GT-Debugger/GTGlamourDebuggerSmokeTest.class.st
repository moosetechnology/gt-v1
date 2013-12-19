Class {
	#name : #GTGlamourDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-Debugger-Tests'
}

{ #category : #'as yet unclassified' }
GTGlamourDebuggerSmokeTest >> debuggerToTest [

	^ GTGlamourDebugger
]

{ #category : #'as yet unclassified' }
GTGlamourDebuggerSmokeTest >> instantiateSession [
	| initialContext process |
	initialContext := [GLMBasicExamples open] asContext.
	process := Process 
		forContext: initialContext
		priority: Processor userInterruptPriority.
		
	self stepToGlamourModelConstructionInProcess: process.	
	^ self debuggerToTest spanNewSessionForContext: process suspendedContext fromProcess: process
]

{ #category : #'as yet unclassified' }
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
