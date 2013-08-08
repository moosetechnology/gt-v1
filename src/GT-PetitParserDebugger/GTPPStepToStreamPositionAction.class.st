Class {
	#name : #GTPPStepToStreamPositionAction,
	#superclass : #GTPPDebugAction,
	#instVars : [
		'position'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #'as yet unclassified' }
GTPPStepToStreamPositionAction class >> gtNextStreamUpdateAction [
	<gtPPStreamDebuggingAction>
	<gtContextPPStreamDebuggingAction>
	
	^ self new
		label: 'Run to next update';
		icon: GLMUIThemeExtraIcons glamorousInto
]

{ #category : #'as yet unclassified' }
GTPPStepToStreamPositionAction class >> gtSelectedStreamPositionActionFor: aDebugger [
	<gtPPStreamDebuggingAction>
	<gtContextPPStreamDebuggingAction>
	
	^ self new
		position: aDebugger streamSelectionInterval last;
		label: 'Run to here'
]

{ #category : #'as yet unclassified' }
GTPPStepToStreamPositionAction >> executeAction [
	| currentPosition targetPosition |

	currentPosition := self session stream position.
	targetPosition := self position 
		ifNil: [ currentPosition + 1 ]
		ifNotNil: [ :anInteger | anInteger ].
"	targetPosition <= currentPosition ifTrue: [
		targetPosition := currentPosition + 1 ]."
		
	self session
		newStepUntil: (self streamToPosition: targetPosition) from: self startContext.
]

{ #category : #accessing }
GTPPStepToStreamPositionAction >> position [
	
	^ position
]

{ #category : #accessing }
GTPPStepToStreamPositionAction >> position: anInteger [
	
	position := anInteger
]

{ #category : #'as yet unclassified' }
GTPPStepToStreamPositionAction >> streamToPosition: anInteger [

	^ self session createPredicateForBlock: [
		self session stream position >= anInteger ]
]
