Class {
	#name : #GTPPStepToNextParserAction,
	#superclass : #DebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPStepToNextParserAction class >> gtActionType [
	<gtPPDebuggingAction>
]

{ #category : #'as yet unclassified' }
GTPPStepToNextParserAction >> appliesToContext: aContext [

	^ (GTPPContextLocator new locateRootParserContextFor: aContext) notNil
]

{ #category : #'as yet unclassified' }
GTPPStepToNextParserAction >> defaultLabel [ 

	^ 'Next parser'
]

{ #category : #'as yet unclassified' }
GTPPStepToNextParserAction >> executeAction [
	
	self debugger stepToNextParser
]
