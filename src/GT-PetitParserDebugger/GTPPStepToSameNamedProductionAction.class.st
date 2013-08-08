Class {
	#name : #GTPPStepToSameNamedProductionAction,
	#superclass : #GTPPStepToNextNamedProductionAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPStepToSameNamedProductionAction class >> gtActionType [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>

	
]

{ #category : #testing }
GTPPStepToSameNamedProductionAction >> appliesToContext: aContext [

	^ (super appliesToContext: aContext) and: [ 
		self session isNamedPPParser: aContext receiver ]
]

{ #category : #accessing }
GTPPStepToSameNamedProductionAction >> defaultCategory [

	^ 'Next parser invocation'
]

{ #category : #accessing }
GTPPStepToSameNamedProductionAction >> defaultLabel [

	^ 'same production'
]

{ #category : #accessing }
GTPPStepToSameNamedProductionAction >> defaultOrder [

	^ 31
]

{ #category : #accessing }
GTPPStepToSameNamedProductionAction >> defaultProduction [

	^ self currentContext receiver name
]
