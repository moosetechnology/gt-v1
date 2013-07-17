Class {
	#name : #GTPPStepToNextNonDelegateParseMethodAction,
	#superclass : #DebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPStepToNextNonDelegateParseMethodAction class >> gtActionType [
	<gtPPDebuggingAction>
]

{ #category : #'as yet unclassified' }
GTPPStepToNextNonDelegateParseMethodAction >> appliesToContext: aContext [

	^ (GTPPContextLocator new locateRootParserContextFor: aContext) notNil
]

{ #category : #'as yet unclassified' }
GTPPStepToNextNonDelegateParseMethodAction >> defaultLabel [ 
	
	^ 'Next non-delegate parser'.
]

{ #category : #'as yet unclassified' }
GTPPStepToNextNonDelegateParseMethodAction >> executeAction [

	[ self debugger stepToNextParser ] doWhileTrue: [ self interruptedContext receiver class == PPDelegateParser ]
]
