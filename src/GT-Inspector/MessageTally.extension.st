Extension { #name : #MessageTally }

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorMessageTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ (composite tree)
		title: 'Message tree';
		children: [ :each | each sonsOver: -1 ];
		rootsExpanded;
		morphicSelectionAct: [ :list | GTUtils browseMethod: list selection method ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse (b)';
		format: [ :each | Text fromString: (each method gtDisplayString) , ' (' , each tally printString , ')'];
		when: [ (self sonsOver: -1) notEmpty ]
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorNestingMapIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite roassal
		title: 'Nesting';
		painting: [ :view |
			| builder methods methodNestings |
			builder := ROTreeMapBuilder new.
			builder weightBlock: [ :el | el tally ].
			methods := OrderedCollection new.
			methodNestings := OrderedCollection new.
			self 
				deep: [ :each | each sonsOver: 1 ]
				do: [ :each | methods add: each ]
				relationDo: [ :from :to | methodNestings add: from->to ].
			builder nodes: methods.
			builder nestingFromAssociations: methodNestings.
			builder fillNodes: [:x | true] withColor: (RONColorLinearNormalizer inContext: methods withCommand: [:m | (m isKindOf: ROElement) ifTrue: [ m model tally ] ifFalse: [m tally] ]  lowColor: Color white highColor: Color red ).
			builder withShadedFrames.
			builder drawOn: view raw ];
		when: [ (self sonsOver: -1) notEmpty ]
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorPerformanceChartIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite graphET
		title: 'Chart';
		send: [ :esObject | esObject ifNotNil: [esObject model value] ];
		diagram: [ :renderer |
			| all diag diag2 grouped |
			all := self deepCollect: [ :each | each sonsOver: 1 ].
			grouped := (all groupedBy: [ :each | each method gtDisplayString ]) 
								associations sorted: [:a :b | 
											(a value sumNumbers: #localTally) > 
											(b value sumNumbers: #localTally) ].
			grouped := (grouped first: (20 min: grouped size)) select: [:each | (each value sumNumbers: #localTally) > 0].
			diag := (GETHorizontalBarDiagram new)
				xAxisLabel: 'Activations';
				modelLabels: [:each | each key ];
				x: [:each | each value size];
				valueAxis;
				color: Color veryLightGray;
				axisColor: Color veryLightGray;
				models: grouped.
			diag2 := (GETHorizontalBarDiagram new)
				xAxisLabel: 'Local duration (ms)';
				x: [:each | each value sumNumbers: #localTally];
				regularAxis;
				xAxisOnTop;
				gapFraction: 1 / 2;
				color: (Color red);
				axisColor: (Color red);
				models: grouped.
			(renderer unionDiagram)
				add: diag;
				add: diag2 ] ;
		when: [ (self sonsOver: -1) notEmpty ]
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
