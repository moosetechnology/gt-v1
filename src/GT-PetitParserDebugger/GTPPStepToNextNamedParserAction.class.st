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

{ #category : #'as yet unclassified' }
GTPPStepToNextNamedParserAction >> defaultLabel [ 

	^ 'Next parser invocation (any named parser)'
]

{ #category : #'as yet unclassified' }
GTPPStepToNextNamedParserAction >> defaultOrder [

	^ 29
]

{ #category : #'as yet unclassified' }
GTPPStepToNextNamedParserAction >> executeAction [
	
	self session 
		stepOverInitialInstructionForContext: self startContext;
		stepToNextNamedParserFromContext: self startContext
]
