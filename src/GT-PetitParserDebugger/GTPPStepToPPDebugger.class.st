Class {
	#name : #GTPPStepToPPDebugger,
	#superclass : #DebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToPPDebugger class >> gtActionType [
	<gtDebuggingAction>
]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> defaultCategory [
	
	^ 'Step to debugger'
]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> defaultLabel [ 
	
	^ GTPPDebugger defaultTitle
]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> execute [

	self session
		newStepUntil: (self session 
			createStepPredicateForPredicate: self isPPDebuggerActivePredicate 
			fromContext: self currentContext ) 
		from: self currentContext.
		
	(self isPPDebuggerActivePredicate matches: self interruptedContext) ifTrue: [ 
		self debugger debug: self interruptedContext using: GTPPDebugger ]

]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> isPPDebuggerActivePredicate [

	self flag: 'Push the methods for creating new predicates to the top session.'.
	^ NewBlockContextPredicate for: [ :aContext |
		aContext isPPParseMethodContext ]
]
