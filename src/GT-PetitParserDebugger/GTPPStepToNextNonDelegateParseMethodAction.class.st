Class {
	#name : #GTPPStepToNextNonDelegateParseMethodAction,
	#superclass : #GTPPDebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToNextNonDelegateParseMethodAction class >> gtActionType [
	<gtPPDebuggingAction>
]

{ #category : #accessing }
GTPPStepToNextNonDelegateParseMethodAction >> defaultLabel [ 
	
	^ 'Next parser invocation (non-delegate parser)'.
]

{ #category : #accessing }
GTPPStepToNextNonDelegateParseMethodAction >> defaultOrder [

	^ 26
]

{ #category : #actions }
GTPPStepToNextNonDelegateParseMethodAction >> executeAction [	

	self session 
		stepOverInitialInstructionForContext: self startContext;
		stepToNextNonDelegateParserFromContext: self startContext

]
