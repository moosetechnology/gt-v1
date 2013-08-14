Class {
	#name : #GTPPStepToNextStreamPositionAction,
	#superclass : #GTPPDebugAction,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPStepToNextStreamPositionAction class >> gtNextStreamUpdateAction [
	<gtPPStreamDebuggingAction>
	<gtContextPPStreamDebuggingAction>
	
	^ self new
		label: 'Run to next update';
		icon: GLMUIThemeExtraIcons glamorousInto
]

{ #category : #actions }
GTPPStepToNextStreamPositionAction >> executeAction [
	| currentPosition |

	currentPosition := self session stream position.
	self session
		newStepUntil: (self streamToDifferentPositionThan: currentPosition) from: self startContext.
]

{ #category : #predicates }
GTPPStepToNextStreamPositionAction >> streamToDifferentPositionThan: anInteger [

	^ self session createPredicateForBlock: [
		self session stream position ~= anInteger ]
]
