Class {
	#name : #GTGlamourDebuggerSmokeTest,
	#superclass : #GTDebuggerSmokeTest,
	#category : #'GT-GlamourDebugger'
}

{ #category : #accessing }
GTGlamourDebuggerSmokeTest >> contextToTest [
	
	^ [GLMBasicExamples open] asContext
]

{ #category : #accessing }
GTGlamourDebuggerSmokeTest >> debuggerToTest [

	^ GTGlamourDebugger
]

{ #category : #utils }
GTGlamourDebuggerSmokeTest >> stepToDebuggerEntryPointIn: aProcess [

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
