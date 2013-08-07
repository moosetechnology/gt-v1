Class {
	#name : #GTPPStepToNextNonDelegateParserAction,
	#superclass : #GTPPDebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToNextNonDelegateParserAction class >> gtActionType [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>
]

{ #category : #accessing }
GTPPStepToNextNonDelegateParserAction >> defaultLabel [ 
	
	^ 'Next parser invocation (non-delegate parser)'.
]

{ #category : #accessing }
GTPPStepToNextNonDelegateParserAction >> defaultOrder [

	^ 26
]

{ #category : #actions }
GTPPStepToNextNonDelegateParserAction >> executeAction [	

	self session 
		stepOverInitialInstructionForContext: self startContext;
		stepToNextNonDelegateParserFromContext: self startContext

]
