Class {
	#name : #GTGlamourStepToPresentationBuildAction,
	#superclass : #DebugAction,
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourStepToPresentationBuildAction class >> gtActionType [
	<gtContextGlamourDebuggingAction>
]

{ #category : #testing }
GTGlamourStepToPresentationBuildAction >> appliesToContext: aContext [

	^ (GTGlamourStackFilter locateBrowserContextFor: aContext) notNil
]

{ #category : #'predicates creation' }
GTGlamourStepToPresentationBuildAction >> createPredicateForBlock: aBlock [ 

	^ NewBlockContextPredicate for: aBlock
]

{ #category : #'predicates creation' }
GTGlamourStepToPresentationBuildAction >> createStepPredicateForBlock: aBlock [ 

	^ self createStepPredicatForPredicate: (self createPredicatForBlock: aBlock)
			
]

{ #category : #'predicates creation' }
GTGlamourStepToPresentationBuildAction >> createStepPredicateForPredicate: aPredicate [ 

	^ (self createPredicateForBlock: [ self debugger isActive not ]) or: aPredicate
	
]

{ #category : #actions }
GTGlamourStepToPresentationBuildAction >> executeAction [
	| presentationCreation presentationCode |
	presentationCreation := self createStepPredicateForPredicate: self presentationCreationPredicate.
	presentationCode := self createStepPredicateForPredicate: self presentationCodePredicate.

	self session newStepUntil: presentationCreation from: self currentContext.
	self session newStepUntil: presentationCode from: self interruptedContext.
	self debugger isActive ifTrue: [ 
		self session stepInto ]
		
	
]

{ #category : #'initialize-release' }
GTGlamourStepToPresentationBuildAction >> initialize [

	self label: 'Next presentation build'.
	self icon: GLMUIThemeExtraIcons glamorousPlay.
]

{ #category : #predicates }
GTGlamourStepToPresentationBuildAction >> presentationCodePredicate [
	
	^ self createPredicateForBlock: [ :aContext |
			aContext selector = #glamourValueWithArgs: and: [ 
				aContext peekInstruction arguments size > 0 and: [ 
				 	#( #value #valueWithArguments:) includes: aContext peekInstruction argument ] ] ]

]

{ #category : #predicates }
GTGlamourStepToPresentationBuildAction >> presentationCreationPredicate [

	^ self createPredicateForBlock: [ :aContext |
			aContext methodClass = GLMPresentStrategy and: [ 
				aContext selector = #presentations and: [ 
					aContext isInitialnstruction ] ] ]


]
