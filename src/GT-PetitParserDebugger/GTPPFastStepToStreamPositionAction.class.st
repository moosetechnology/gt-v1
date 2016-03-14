Class {
	#name : #GTPPFastStepToStreamPositionAction,
	#superclass : #GTReflectivityDebugAction,
	#instVars : [
		'position'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPFastStepToStreamPositionAction class >> gtSelectedStreamPositionActionFor: aDebugger [
	"<gtPPStreamDebuggingAction>
	<gtContextPPStreamDebuggingAction>"
	
	^ (self forDebugger: aDebugger)
		position: aDebugger streamSelectionInterval last;
		label: 'Run to here (fast)'
]

{ #category : #testing }
GTPPFastStepToStreamPositionAction >> appliesToContext: aContext [

	^ self session isActive and: [
		aContext locateTopPPParser notNil ]
]

{ #category : #actions }
GTPPFastStepToStreamPositionAction >> attachBreakpoints [

	self addBreakpoint: (GTDebuggerMethodAfterBreakpoint new
		targetMethod: PPContext>>#next;
		whenReceiver: [ :aPPContext | aPPContext position = self position ]).
]

{ #category : #accessing }
GTPPFastStepToStreamPositionAction >> position [
	
	^ position
]

{ #category : #accessing }
GTPPFastStepToStreamPositionAction >> position: anInteger [
	
	position := anInteger
]
