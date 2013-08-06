Class {
	#name : #GTPPStepToNextParserAction,
	#superclass : #GTPPDebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToNextParserAction class >> gtActionType [
	<gtPPDebuggingAction>
]

{ #category : #accessing }
GTPPStepToNextParserAction >> defaultLabel [ 

	^ 'Next parser invocation (any parser)'
]

{ #category : #accessing }
GTPPStepToNextParserAction >> defaultOrder [

	^ 25
]

{ #category : #actions }
GTPPStepToNextParserAction >> executeAction [
	
	self session 
		stepOverInitialInstructionForContext: self startContext;
		stepToNextParserFromContext: self startContext
]
