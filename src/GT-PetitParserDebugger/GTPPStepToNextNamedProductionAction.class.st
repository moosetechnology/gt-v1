Class {
	#name : #GTPPStepToNextNamedProductionAction,
	#superclass : #GTPPDebugAction,
	#instVars : [
		'production'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToNextNamedProductionAction class >> gtToNextProductionActionFor: aDebugger [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>

	^ self new 
		production: nil;
		label: 'named parser';
		category: 'Next parser invocation';
		order: 26
]

{ #category : #registration }
GTPPStepToNextNamedProductionAction class >> gtToProductionActionFor: aDebugger [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>
	| order allSuperclasses allParserSuperclasses showedProductions actions |

	order := 40.
	actions := OrderedCollection new.
	showedProductions := OrderedCollection new.
	allSuperclasses := aDebugger session rootParser class withAllSuperclasses.
	"Return 2 in the ifAbsent: block so that if PPCompositeParser is not a superclass only the current class is returned"
	(allParserSuperclasses := allSuperclasses copyFrom: 1 to: (allSuperclasses indexOf: PPCompositeParser ifAbsent: [ 2 ]) - 1) do: [ :each |
		| productions |
		productions := aDebugger productionSelectorsFrom: each.
		productions := productions copyWithoutAll: showedProductions.
		showedProductions addAll: productions.
		
		actions addAll: (productions collect: [ :aProduction |
			self new 
				production: aProduction;
				label: aProduction asString;
				category: 'Next production', (allParserSuperclasses size = 1 ifTrue:[ '' ] ifFalse:[ ' [', each name, ']']);
				order: (order := order + 1) ]) ].
		
	^ actions 
]

{ #category : #accessing }
GTPPStepToNextNamedProductionAction >> defaultProduction [

	^ nil
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
