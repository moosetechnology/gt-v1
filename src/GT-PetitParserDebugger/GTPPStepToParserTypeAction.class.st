Class {
	#name : #GTPPStepToParserTypeAction,
	#superclass : #GTPPDebugAction,
	#instVars : [
		'parserClass'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToParserTypeAction class >> gtActionFor: aDebugger [
	<gtPPDebuggingAction>
	<gtContextPPDebuggingAction>
	|order|
	
	order := 50.
	^ self parserTypes collect: [ :each |
		self new
			parserClass: each;
			label: each name;
			category: 'Next type';
			order: (order := order + 1) ]
]

{ #category : #private }
GTPPStepToParserTypeAction class >> parserTypes [

	^ { 
		PPDelegateParser. 
		PPActionParser. 
		PPWrappingParser. 
		PPAndParser. 
		PPEndOfInputParser. 
		PPFlattenParser. 
		PPTokenParser. 
		PPMemoizedParser. 
		PPNotParser. 
		PPOptionalParser. 
		PPGreedyRepeatingParser. 
		PPLazyRepeatingParser. 
		PPPossessiveRepeatingParser. 
		PPTrimmingParser. 
		PPEpsilonParser. 
		PPFailingParser. 
		PPChoiceParser. 
		PPSequenceParser. 
		PPLiteralObjectParser. 
		PPLiteralSequenceParser. 
		PPPluggableParser. 
		PPPredicateObjectParser. 
		PPPredicateSequenceParser
	}
]

{ #category : #accessing }
GTPPStepToParserTypeAction >> defaultParserClass [

	^ nil
]

{ #category : #actions }
GTPPStepToParserTypeAction >> executeAction [

	self session
		stepOverInitialInstructionForContext: self startContext;
		newStepUntil: self sameParserTypePredicate from: self startContext.
]

{ #category : #accessing }
GTPPStepToParserTypeAction >> parserClass [

	^ parserClass ifNil: [ self defaultParserClass ]
]

{ #category : #accessing }
GTPPStepToParserTypeAction >> parserClass: aClass [ 

	parserClass := aClass
]

{ #category : #predicates }
GTPPStepToParserTypeAction >> sameParserClassPredicate [

	^ self session createPredicateForBlock: [ :aContext |
		aContext receiver class == self parserClass ]
]

{ #category : #predicates }
GTPPStepToParserTypeAction >> sameParserTypePredicate [

	^ self session parseMethodEntryPredicate and: self sameParserClassPredicate
]
