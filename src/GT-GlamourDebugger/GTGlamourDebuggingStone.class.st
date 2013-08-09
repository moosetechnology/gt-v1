Class {
	#name : #GTGlamourDebuggingStone,
	#superclass : #GTDebuggingStone,
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourDebuggingStone >> hasPresentationConditionReachedTarget [

	^ self session context peekInstruction argument = #condition
]

{ #category : #testing }
GTGlamourDebuggingStone >> isPresentationConditionValid [

	^ (self session context receiver condition 
		ifNil: [ false ]
		ifNotNil: [ :aBlock | aBlock printString ~= [true] printString ])
]

{ #category : #testing }
GTGlamourDebuggingStone >> isPresentationCreationValid [

	^ self session context receiver presentationsFactory notNil
	
]

{ #category : #testing }
GTGlamourDebuggingStone >> isTransmissionConditionValid [

	^ self session context receiver condition notNil
]

{ #category : #testing }
GTGlamourDebuggingStone >> isTransmissionTranformationValid [

	^ self session context receiver transformation notNil
]

{ #category : #'as yet unclassified' }
GTGlamourDebuggingStone >> presentationCreationPredicate [

	^ self session createPredicateForBlock: [ :aContext |
			aContext selector = #glamourValueWithArgs: and: [ 
				aContext peekInstruction arguments size > 0 and: [
				 	#( #value #valueWithArguments:) includes: aContext peekInstruction argument ] ] ]


]

{ #category : #actions }
GTGlamourDebuggingStone >> stepToBlock [

	self session newStepUntil: self presentationCreationPredicate from: self session context.
	self session isActive ifTrue: [ 
		self session stepInto ].
	^ true
]

{ #category : #actions }
GTGlamourDebuggingStone >> stepToPresentationCondition [

	^ self stepToBlock
]

{ #category : #actions }
GTGlamourDebuggingStone >> stepToPresentationCreation [

	^ self stepToBlock
]

{ #category : #actions }
GTGlamourDebuggingStone >> stepToTransmissionCondition [

	^ self stepToBlock
]

{ #category : #actions }
GTGlamourDebuggingStone >> stepToTransmissionTransformation [

	^ self stepToBlock
]
