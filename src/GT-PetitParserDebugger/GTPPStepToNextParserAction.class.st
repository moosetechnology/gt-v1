Class {
	#name : #GTPPStepToNextParserAction,
	#superclass : #GTPPDebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToNextParserAction class >> gtActionType [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>
]

{ #category : #accessing }
GTPPStepToNextParserAction >> defaultCategory [

	^ 'Next parser invocation'
]

{ #category : #accessing }
GTPPStepToNextParserAction >> defaultLabel [ 

	^ 'any parser'
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
