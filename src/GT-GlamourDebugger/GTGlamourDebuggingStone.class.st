Class {
	#name : #GTGlamourDebuggingStone,
	#superclass : #GTDebuggingStone,
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourDebuggingStone >> hasCondition [

	^ false
]

{ #category : #'as yet unclassified' }
GTGlamourDebuggingStone >> hasTransformation [

	^ false
]

{ #category : #'as yet unclassified' }
GTGlamourDebuggingStone >> presentationCreationPredicate [

	^ self session createPredicateForBlock: [ :aContext |
			aContext selector = #glamourValueWithArgs: and: [ 
				aContext peekInstruction arguments size > 0 and: [ 
				 	#( #value #valueWithArguments:) includes: aContext peekInstruction argument ] ] ]


]

{ #category : #'as yet unclassified' }
GTGlamourDebuggingStone >> stepToPresentationCreation [

	self session newStepUntil: self presentationCreationPredicate from: self interruptedContext.
	self session isActive ifTrue: [ 
		self session stepInto ]
]

{ #category : #'as yet unclassified' }
GTGlamourDebuggingStone >> stepToPresentationCreationFrom: aContext [

	self session newStepUntil: self presentationCreationPredicate from: aContext.
	self session isActive ifTrue: [ 
		self session stepInto ].
	^ true
]
