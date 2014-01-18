Class {
	#name : #GTInspectorMessageTallyCharter,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Inspector'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GTInspectorMessageTallyCharter >> performanceOf: aMessageTally with: renderer in: presentation [
	| all diag diag2 grouped metric |
	metric := #localTally.
			all := aMessageTally deepCollect: [ :each | each sonsOver: 1 ].
			grouped := (all groupedBy: [ :each | each method gtDisplayString ]) 
								associations sorted: [:a :b | 
											(a value sumNumbers: metric) > 
											(b value sumNumbers: metric) ].
			grouped := (grouped first: (20 min: grouped size)) select: [:each | (each value sumNumbers: metric) > 0].
			diag := (GETHorizontalBarDiagram new)
				xAxisLabel: 'Locations';
				modelLabels: [:each | each key ];
				x: [:each | each value size];
				valueAxis;
				color: Color veryLightGray;
				axisColor: Color veryLightGray;
				on: ROMouseClick do: [:event | presentation selection: event model value ];
				models: grouped.
			diag2 := (GETHorizontalBarDiagram new)
				xAxisLabel: 'Tallies';
				x: [:each | each value sumNumbers: metric];
				regularAxis;
				xAxisOnTop;
				gapFraction: 1 / 2;
				color: (Color red);
				axisColor: (Color red);
				on: ROMouseClick do: [:event | presentation selection: event model value ];
				models: grouped.
			(renderer unionDiagram)
				add: diag;
				add: diag2
]
