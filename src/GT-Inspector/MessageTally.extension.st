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
		format: [ :each | Text fromString: (each method gtDisplayString) , ' (' , each tally printString , ')']
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
			grouped := (all groupedBy: [ :each | each method gtDisplayString ]) associations sorted: [:a :b | (a value sumNumbers: #tally) > (b value sumNumbers: #tally) ].
			grouped := grouped first: (20 min: grouped size).
			diag := (GETHorizontalBarDiagram new)
				xAxisLabel: 'Activations';
				modelLabels: [:each | each key ];
				x: [:each | each value size];
				valueAxis;
				color: Color veryLightGray;
				axisColor: Color veryLightGray;
				models: grouped.
			diag2 := (GETHorizontalBarDiagram new)
				xAxisLabel: 'Duration (ms)';
				x: [:each | each value sumNumbers: #tally];
				regularAxis;
				xAxisOnTop;
				gapFraction: 1 / 2;
				color: (Color red);
				axisColor: (Color red);
				models: grouped.
			(renderer unionDiagram)
				add: diag;
				add: diag2 ] 
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ self method ifNotNil: [
		self method gtInspectorSourceIn: composite]
]
