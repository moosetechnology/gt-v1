Class {
	#name : #GTPPFastStepToStreamPositionChangedAction,
	#superclass : #GTReflectivityDebugAction,
	#instVars : [
		'initialPosition'
	],
	#category : #'GT-PetitParserDebugger'
}

{ #category : #registration }
GTPPFastStepToStreamPositionChangedAction class >> gtSelectedStreamPositionActionFor: aDebugger [
	"<gtPPStreamDebuggingAction>
	<gtContextPPStreamDebuggingAction>"
	
	^ (self forDebugger: aDebugger)
		label: 'Run to next update (fast)';
		icon: GLMUIThemeExtraIcons glamorousInto
]

{ #category : #testing }
GTPPFastStepToStreamPositionChangedAction >> appliesToContext: aContext [

	^ self session isActive and: [
		aContext locateTopPPParser notNil ]
]

{ #category : #actions }
GTPPFastStepToStreamPositionChangedAction >> attachBreakpoints [

	self addBreakpoint: (GTDebuggerMethodAfterBreakpoint new
		targetMethod: PPContext>>#next;
		whenReceiver: [ :aPPContext | aPPContext position ~= self initialPosition ]).
]

{ #category : #initialization }
GTPPFastStepToStreamPositionChangedAction >> forDebugger: aDebugger [

	super forDebugger: aDebugger.
	self initialPosition: aDebugger session stream position
]

{ #category : #accessing }
GTPPFastStepToStreamPositionChangedAction >> initialPosition [

	^ initialPosition
]

{ #category : #accessing }
GTPPFastStepToStreamPositionChangedAction >> initialPosition: anInteger [

	initialPosition := anInteger
]
