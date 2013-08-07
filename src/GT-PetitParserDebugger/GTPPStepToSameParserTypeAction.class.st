Class {
	#name : #GTPPStepToSameParserTypeAction,
	#superclass : #GTPPDebugAction,
	#instVars : [
		'parser'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToSameParserTypeAction class >> gtActionFor: aDebugger [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>
	
	^ self new
		parser: aDebugger currentContext receiver
]

{ #category : #testing }
GTPPStepToSameParserTypeAction >> appliesToContext: aContext [

	^ (super appliesToContext: aContext) and: [ 
		aContext receiver class inheritsFrom: PPParser ]
]

{ #category : #accessing }
GTPPStepToSameParserTypeAction >> defaultCategory [

	^ 'Next parser invocation'
]

{ #category : #accessing }
GTPPStepToSameParserTypeAction >> defaultLabel [ 

	^ 'same class type'
]

{ #category : #accessing }
GTPPStepToSameParserTypeAction >> defaultOrder [

	^ 29
]

{ #category : #actions }
GTPPStepToSameParserTypeAction >> executeAction [

	self session
		stepOverInitialInstructionForContext: self startContext;
		newStepUntil: self sameParserTypePredicate from: self startContext.
]

{ #category : #accessing }
GTPPStepToSameParserTypeAction >> parser [
	^ parser
]

{ #category : #accessing }
GTPPStepToSameParserTypeAction >> parser: anObject [
	parser := anObject
]

{ #category : #predicates }
GTPPStepToSameParserTypeAction >> sameParserClassPredicate [

	^ self session createPredicateForBlock: [ :aContext |
		aContext receiver class == self parser class ]
]

{ #category : #predicates }
GTPPStepToSameParserTypeAction >> sameParserTypePredicate [

	^ self session parseMethodEntryPredicate and: self sameParserClassPredicate
]
