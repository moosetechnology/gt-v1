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
GTPPStepToPPDebugger >> appliesToContext: aContext [
	self flag: 'A better mechanism for determining if an action is active or not is needed.'.
	
	^ self debugger class ~= self debuggerClass
]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> debuggerClass [
	
	^ GTPPDebugger
]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> defaultCategory [
	
	^ 'Step to debugger'
]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> defaultLabel [ 
	
	^ self debuggerClass defaultTitle
]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> execute [

	self session
		stepUntil: (self session 
			createStepPredicateForPredicate: self isPPDebuggerActivePredicate 
			fromContext: self currentContext ) 
		from: self currentContext.
		
	(self isPPDebuggerActivePredicate matches: self interruptedContext) ifTrue: [ 
		self debugger debug: self interruptedContext using: self debuggerClass ]

]

{ #category : #'as yet unclassified' }
GTPPStepToPPDebugger >> isPPDebuggerActivePredicate [

	^ self session createPredicateForBlock: [ :aContext |
		aContext isPPParseMethodContext ]
]
