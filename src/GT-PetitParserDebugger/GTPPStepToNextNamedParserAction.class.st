Class {
	#name : #GTPPStepToNextNamedParserAction,
	#superclass : #GTPPDebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToNextNamedParserAction class >> gtActionType [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>
]

{ #category : #accessing }
GTPPStepToNextNamedParserAction >> defaultLabel [ 

	^ 'Next parser invocation (any named parser)'
]

{ #category : #accessing }
GTPPStepToNextNamedParserAction >> defaultOrder [

	^ 29
]

{ #category : #actions }
GTPPStepToNextNamedParserAction >> executeAction [
	
	self session 
		stepOverInitialInstructionForContext: self startContext;
		stepToNextNamedParserFromContext: self startContext
]
