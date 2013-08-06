Class {
	#name : #GTPPDebugSession,
	#superclass : #DebugSession,
	#instVars : [
		'rootParserContext'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'predicates creation' }
GTPPDebugSession >> createPredicateForBlock: aBlock [ 

	^ NewBlockContextPredicate for: aBlock
]

{ #category : #'predicates creation' }
GTPPDebugSession >> createStepPredicateForBlock: aBlock [ 

	^ self createStepPredicatForPredicate: (self createPredicatForBlock: aBlock)
			
]

{ #category : #'predicates creation' }
GTPPDebugSession >> createStepPredicateForPredicate: aPredicate [ 

	^ (self createPredicateForBlock: [ self isActive not ]) or: aPredicate
	
]

{ #category : #testing }
GTPPDebugSession >> isActive [

	^ rootParserContext 
		ifNil: [ false ] 
		ifNotNil: [ 
			rootParserContext isDead not and: [
				
				rootParserContext ~= self context or: [rootParserContext willReturn not ]
				
				 ]  ]
]

{ #category : #'debugging actions' }
GTPPDebugSession >> newStepUntil: aPredicate from: aContext [ 

	^ super 
		newStepUntil: (self createStepPredicateForPredicate: aPredicate) 
		from: aContext 
]

{ #category : #predicates }
GTPPDebugSession >> notDelegateParserClassPredicate [

	^ self createPredicateForBlock: [ :aContext |
		aContext receiver class ~= PPDelegateParser ]
]

{ #category : #predicates }
GTPPDebugSession >> parseMethodEntryPredicate [

	^ self createPredicateForBlock: [ :aContext |
			(aContext methodClass inheritsFrom: PPParser) and: [ 
				aContext selector = #parseOn: and: [ 
					aContext isInitialnstruction ] ] ]
]

{ #category : #initialization }
GTPPDebugSession >> process: aProcess context: aContext [

	super process: aProcess context: aContext.
	
	self flag: 'Have a method that is only called when the session is created and put this there'.
	rootParserContext ifNil:  [
		rootParserContext := aContext locateRootPPParser]
]

{ #category : #'debugging actions' }
GTPPDebugSession >> stepOverInitialInstructionForContext: aContext [
	
	(self isActive and: [
		self parseMethodEntryPredicate matches: aContext ])  
			ifTrue: [ self stepInto ]
	
]

{ #category : #'debugging actions' }
GTPPDebugSession >> stepToNextNonDelegateParserFromContext: aContext [

	self 
		newStepUntil: (self parseMethodEntryPredicate and: self notDelegateParserClassPredicate)
		from: aContext
]

{ #category : #'debugging actions' }
GTPPDebugSession >> stepToNextParserFromContext: aContext [

	self 
		newStepUntil: self parseMethodEntryPredicate 
		from: aContext
]
