"
Helper class for displaying charts specific for a MessageTally.
"
Class {
	#name : #GTInspectorMessageTallyCharter,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-InspectorExtensions-CoreRoassal'
}

{ #category : #visualization }
GTInspectorMessageTallyCharter >> nestingMapOf: aMessageTally on: view [
	"This is provides a treemap visualization of a message tally"
		
	| builder methods methodNestings |
	builder := ROTreeMapBuilder new.
	builder weightBlock: [ :el | el children size max: 1 ].
	methods := OrderedCollection new.
	methodNestings := OrderedCollection new.
	aMessageTally 
		deep: #children
		do: [ :each | methods add: each ]
		relationDo: [ :from :to | methodNestings add: from->to ].
	builder nodes: methods.
	builder nestingFromAssociations: methodNestings.
	builder fillNodes: [:x | true] withColor: (RONColorLinearNormalizer inContext: methods withCommand: [:m | (m isKindOf: ROElement) ifTrue: [ m model localTally ] ifFalse: [m localTally] ]  lowColor: Color white highColor: Color red ).
	builder withShadedFrames.
	builder drawOn: view raw
]

{ #category : #visualization }
GTInspectorMessageTallyCharter >> performanceOf: aMessageTally with: builder in: presentation [
	"Displays a Graph-ET chart showing the top 20 most costly methods within a MessageTally.
	For each method it sows the number of occurences of a method and the 
	total amount of local tallies for that method. Useful for identifying outliers 
	within one execution."
	
	| all grouped metric |
	metric := #localTally.
	all := aMessageTally deepCollect: [ :each | each sonsOver: 1 ].
	grouped := (all groupedBy: [ :each | String streamContents: [:s | each gtDisplayIdentifierOn: s] ]) 
						associations sorted: [:a :b | 
									(a value sumNumbers: metric) > 
									(b value sumNumbers: metric) ].
	grouped := (grouped first: (20 min: grouped size)) select: [:each | (each value sumNumbers: metric) > 0].
	builder pointName: [ :each | each key ].
	builder points: grouped.
	builder bottomValue: [ :each | each key size ] titled: 'Locations'.
	builder topValue: [ :each | each value sumNumbers: metric ] titled: 'Tallies'
]
