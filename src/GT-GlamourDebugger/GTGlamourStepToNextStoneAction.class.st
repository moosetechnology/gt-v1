Class {
	#name : #GTGlamourStepToNextStoneAction,
	#superclass : #DebugAction,
	#instVars : [
		'debugStoneType'
	],
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourStepToNextStoneAction class >> gtActionType [
	<gtGlamourDebuggingAction>
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

	^ #debugStone:label:
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
			(debugingStone reachedTarget and: [ 
				debugingStone isActive and: [ 
					debugingStone completeAction ] ]) 
						"After the first time use the interruptedContext (start the search from where it was left of).
						Here the interruptedContext it is the same as the suspended context of the process."
						ifFalse: [ debugingStone := self stepToDebuggingStoneFrom: self interruptedContext ]
						"If a debuging stone reached its destination stop the search."
						ifTrue: [ ^ self ] ]
	
]

{ #category : #actions }
GTGlamourStepToNextStoneAction >> stepToDebuggingStoneFrom: aContext [

	"Make sure the execution advances, and does not check the same context."
	self session stepInto: aContext.

	self session 
		newStepUntil: self debuggingStone
		from: self interruptedContext.
		
	^ self session isActive 
		ifTrue: [ 
			GTGlamourDebuggingStone 
				"Here interruptedContext is the same as the suspended context of the process."
				forPragma: (self interruptedContext method pragmaAt: self debuggingStonePragma) 
				forSession: self session  ]
		ifFalse: [ nil ]
]
