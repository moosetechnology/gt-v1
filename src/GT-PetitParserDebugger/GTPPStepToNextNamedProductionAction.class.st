Class {
	#name : #GTPPStepToNextNamedProductionAction,
	#superclass : #GTPPDebugAction,
	#instVars : [
		'production'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPStepToNextNamedProductionAction class >> gtToNextProductionActionFor: aDebugger [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>

	^ self new 
		production: nil;
		label: 'any named parser';
		category: 'Next parser invocation';
		order: 26
]

{ #category : #'as yet unclassified' }
GTPPStepToNextNamedProductionAction class >> gtToProductionActionFor: aDebugger [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>
	| order |
	
	order := 40.
	^ (aDebugger productionSelectorsFrom: aDebugger session rootParser class) collect: [ :aProduction |
		self new 
			production: aProduction;
			label: aProduction asString;
			category: 'Next production';
			order: (order := order + 1) ]
]

{ #category : #actions }
GTPPStepToNextNamedProductionAction >> executeAction [
	
	self session 
		stepOverInitialInstructionForContext: self startContext;
		stepToNextProduction: self production fromContext: self startContext
]

{ #category : #accessing }
GTPPStepToNextNamedProductionAction >> production [
	
	^ production
]

{ #category : #accessing }
GTPPStepToNextNamedProductionAction >> production: anObject [
	
	production := anObject
]
