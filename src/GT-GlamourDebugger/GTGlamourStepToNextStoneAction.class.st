Class {
	#name : #GTGlamourStepToNextStoneAction,
	#superclass : #DebugAction,
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourStepToNextStoneAction class >> gtActionType [
	<gtContextGlamourDebuggingAction>
]

{ #category : #testing }
GTGlamourStepToNextStoneAction >> appliesToContext: aContext [

	^ aContext locateBrowserContext notNil
]

{ #category : #predicates }
GTGlamourStepToNextStoneAction >> debuggingStone [

	^ self session createPredicateForBlock: [ :aContext |
			aContext isInitialnstruction and: [  
				(aContext method pragmaAt: self debuggingStonePragma) notNil ] ]
]

{ #category : #predicates }
GTGlamourStepToNextStoneAction >> debuggingStonePragma [

	^ #debugStone:label:validateWith:nextAction:mustReach:
]

{ #category : #accessing }
GTGlamourStepToNextStoneAction >> defaultLabel [

	^ 'Next debug stone'
]

{ #category : #actions }
GTGlamourStepToNextStoneAction >> executeAction [
	| debugingStone |
	
	"The first time start searching for a debuging stone from the context selected by the user."
	debugingStone := self stepToDebuggingStoneFrom: self currentContext.
	 [ debugingStone notNil ] 
		whileTrue: [ 
			(debugingStone isActive and: [ 
				debugingStone reachDestinationFromContext: self interruptedContext ]) 
					"After the first time use the interruptedContext (start the search from where it was left of).
					Here the interruptedContext it is the same as the suspended context of the process."
					ifFalse: [ debugingStone := self stepToDebuggingStoneFrom: self interruptedContext ]
					"If a debuging stone reached its destination stop the search."
					ifTrue: [ ^ self ] ]
	
]

{ #category : #actions }
GTGlamourStepToNextStoneAction >> stepToDebuggingStoneFrom: aContext [

	self session 
		newStepUntil: self debuggingStone
		from: aContext.
		
	^ self session isActive 
		ifTrue: [ 
			GTGlamourDebuggingStone 
				"Here interruptedContext is the same as the suspended context of the process."
				forPragma: (self interruptedContext method pragmaAt: self debuggingStonePragma) 
				forSession: self session  ]
		ifFalse: [ nil ]
]
