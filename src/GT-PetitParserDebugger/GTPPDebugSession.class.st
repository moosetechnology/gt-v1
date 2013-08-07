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

{ #category : #testing }
GTPPDebugSession >> isNamedPPParser: anObject [ 

	^ (self isPPParser: anObject) and: [ 
		anObject name notNil ]
	
]

{ #category : #testing }
GTPPDebugSession >> isPPParser: anObject [ 

	^ self isPPParserClass: anObject class
	
]

{ #category : #testing }
GTPPDebugSession >> isPPParserClass: aClass [

	^ aClass inheritsFrom: PPParser 

	
]

{ #category : #predicates }
GTPPDebugSession >> namedParserPredicate [

	^ self createPredicateForBlock: [ :aContext |
		self isNamedPPParser: aContext receiver ]
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
		(self isPPParser: aContext receiver) and: [ 
			aContext receiver class ~= PPDelegateParser ] ]
]

{ #category : #predicates }
GTPPDebugSession >> parseMethodEntryPredicate [

	^ self createPredicateForBlock: [ :aContext |
			(self isPPParser: aContext receiver) and: [ 
				aContext selector = #parseOn: and: [ 
					aContext isInitialnstruction ] ] ]
]

{ #category : #predicates }
GTPPDebugSession >> parseMethodPredicate [

	^ self createPredicateForBlock: [ :aContext |
			(self isPPParser: aContext receiver) and: [ 
				aContext selector = #parseOn: ] ]
]

{ #category : #initialization }
GTPPDebugSession >> process: aProcess context: aContext [

	super process: aProcess context: aContext.
	
	self flag: 'Have a method that is only called when the session is created and put this there'.
	rootParserContext ifNil:  [
		rootParserContext := aContext locateRootPPParser]
]

{ #category : #accessing }
GTPPDebugSession >> rootParser [

	^ rootParserContext receiver
]

{ #category : #accessing }
GTPPDebugSession >> rootParserContext [

	^ rootParserContext
]

{ #category : #'debugging actions' }
GTPPDebugSession >> stepOverInitialInstructionForContext: aContext [
	
	(self isActive and: [
		self parseMethodEntryPredicate matches: aContext ])  
			ifTrue: [ self stepInto ]
	
]

{ #category : #'debugging actions' }
GTPPDebugSession >> stepToNextNamedParserFromContext: aContext [

	self 
		newStepUntil: (self parseMethodEntryPredicate and: self namedParserPredicate) 
		from: aContext
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

{ #category : #accessing }
GTPPDebugSession >> stream [

	^ self streamFromContext: rootParserContext
]

{ #category : #accessing }
GTPPDebugSession >> streamFromContext: aContext [

	^ aContext tempAt: 1
]
