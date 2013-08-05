Class {
	#name : #GTPPStepToSameParserAction,
	#superclass : #GTPPDebugAction,
	#instVars : [
		'parser'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPStepToSameParserAction class >> gtContextActionFor: aDebugger [
	<gtContextPPDebuggingAction>
	
	^ self new
		parser: aDebugger selectedContext receiver
]

{ #category : #'as yet unclassified' }
GTPPStepToSameParserAction class >> gtToolbarActionFor: aDebugger [
	<gtPPDebuggingAction>
	
	^ self new
		parser: aDebugger interruptedContext receiver
]

{ #category : #testing }
GTPPStepToSameParserAction >> appliesToContext: aContext [

	^ (super appliesToContext: aContext) and: [ 
		aContext receiver class inheritsFrom: PPParser ]
]

{ #category : #accessing }
GTPPStepToSameParserAction >> defaultLabel [ 

	^ 'Next parser invocation (same parser)'
]

{ #category : #accessing }
GTPPStepToSameParserAction >> defaultOrder [

	^ 27
]

{ #category : #actions }
GTPPStepToSameParserAction >> executeAction [

	self session
		stepOverInitialInstructionForContext: self startContext;
		newStepUntil: self sameParserPredicate from: self startContext.
]

{ #category : #accessing }
GTPPStepToSameParserAction >> parser [

	^ parser
]

{ #category : #accessing }
GTPPStepToSameParserAction >> parser: anObject [

	parser := anObject
]

{ #category : #predicates }
GTPPStepToSameParserAction >> sameParserObjectPredicate [

	^ self session createPredicateForBlock: [ :aContext |
		aContext receiver ~= self parser ]
]

{ #category : #predicates }
GTPPStepToSameParserAction >> sameParserPredicate [

	^ self session parseMethodEntryPredicate and: self sameParserObjectPredicate
]
