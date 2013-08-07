Class {
	#name : #GTPPStepToNamedParserAction,
	#superclass : #GTPPDebugAction,
	#instVars : [
		'production'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPStepToNamedParserAction class >> gtActionFor: aDebugger [
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
GTPPStepToNamedParserAction >> executeAction [
	
	self session 
		stepOverInitialInstructionForContext: self startContext;
		stepToNextProduction: self production fromContext: self startContext
]

{ #category : #accessing }
GTPPStepToNamedParserAction >> production [
	
	^ production
]

{ #category : #accessing }
GTPPStepToNamedParserAction >> production: anObject [
	
	production := anObject
]
