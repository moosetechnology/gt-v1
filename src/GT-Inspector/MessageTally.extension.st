Extension { #name : #MessageTally }

{ #category : #'*gt-inspector' }
MessageTally >> gtDisplayOn: aStream [
	self method gtDisplayOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self tally printString;
		nextPutAll: ')'
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorMessageTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	| methods normalizer |
	methods := OrderedCollection new.
	self 
		withDeep: [ :each | each sonsOver: 1 ]
		do: [ :each | methods add: each ].
	normalizer := RONColorLinearNormalizer 
						inContext: methods 
						withCommand: #tally 
						lowColor: Color gray 
						highColor: Color red.
	^ (composite tree)
		title: 'Message tree';
		children: [ :each | each sonsOver: -1 ];
		rootsExpanded;
		format: [ :each | 
			Text 
				string: each gtDisplayString
				attributes: { TextColor color: (normalizer roValue: each)}];
		when: [ (self sonsOver: -1) notEmpty ];
		morphicSelectionAct: [ :list | GTUtils browseMethod: list selection method ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse (b)'
		
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorNestingMapIn: composite [
	^ composite roassal
		title: 'Nesting';
		painting: [ :view |
			| builder methods methodNestings |
			builder := ROTreeMapBuilder new.
			builder weightBlock: [ :el | ((el sonsOver: -1) size) max: 1 ].
			methods := OrderedCollection new.
			methodNestings := OrderedCollection new.
			self 
				deep: [ :each | each sonsOver: 1 ]
				do: [ :each | methods add: each ]
				relationDo: [ :from :to | methodNestings add: from->to ].
			builder nodes: methods.
			builder nestingFromAssociations: methodNestings.
			builder fillNodes: [:x | true] withColor: (RONColorLinearNormalizer inContext: methods withCommand: [:m | (m isKindOf: ROElement) ifTrue: [ m model localTally ] ifFalse: [m localTally] ]  lowColor: Color white highColor: Color red ).
			builder withShadedFrames.
			builder drawOn: view raw ];
		when: [ (self sonsOver: -1) notEmpty ]
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorPerformanceChartIn: composite [
	<gtInspectorPresentationOrder: 40>
	| metric |
	metric := #localTally.
	^ composite graphET
		title: 'Chart';
		diagram: [ :renderer :presentation |
			| all diag diag2 grouped |
			all := self deepCollect: [ :each | each sonsOver: 1 ].
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
				add: diag2 ];
		when: [ (self sonsOver: -1) notEmpty ]
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorReportIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite text
		title: 'Report';
		display: [ 
			String streamContents: [:s | self report: s ] ]
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ self method ifNotNil: [
		self method gtInspectorSourceIn: composite]
]

{ #category : #'*gt-inspector' }
MessageTally >> localTally [
	^ (receivers ifNil: [#()]) 
		inject: self tally
		into: [ :diff :each | diff - each tally ]
]

{ #category : #'*gt-inspector' }
MessageTally >> localTime [
	^ (receivers ifNil: [#()]) 
		inject: self time 
		into: [ :diff :each | diff - each time ]
]
