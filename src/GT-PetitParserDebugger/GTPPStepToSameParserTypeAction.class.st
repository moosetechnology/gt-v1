Class {
	#name : #GTPPStepToSameParserTypeAction,
	#superclass : #GTPPStepToParserTypeAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPStepToSameParserTypeAction class >> gtActionType [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>
]

{ #category : #'as yet unclassified' }
GTPPStepToSameParserTypeAction >> appliesToContext: aContext [

	^ (super appliesToContext: aContext) and: [ 
		aContext receiver class inheritsFrom: PPParser ]
]

{ #category : #'as yet unclassified' }
GTPPStepToSameParserTypeAction >> defaultCategory [

	^ 'Next parser invocation'
]

{ #category : #'as yet unclassified' }
GTPPStepToSameParserTypeAction >> defaultLabel [ 

	^ 'same class'
]

{ #category : #'as yet unclassified' }
GTPPStepToSameParserTypeAction >> defaultOrder [

	^ 32
]

{ #category : #'as yet unclassified' }
GTPPStepToSameParserTypeAction >> defaultParserClass [

	^ self currentContext receiver class
]
