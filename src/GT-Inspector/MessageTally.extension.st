Extension { #name : #MessageTally }

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorMessageTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ (composite tree)
		title: 'Message tree';
		children: [ :each | each sonsOver: -1 ];
		morphicSelectionAct: [ :list | GTUtils browseMethod: list selection method ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse (b)';
		format: [ :each | Text fromString: (each method gtDisplayString) , ' (' , each tally printString , ')']
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorPerformanceChartIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite eyesee
		title: 'Chart';
		diagram: [ :renderer |
			| all diag diag2 grouped |
			all:= self deepCollect: [ :each | each sonsOver: 1 ].
			grouped := (all groupedBy: [ :each | each method gtDisplayString ]) associations sorted: [:a :b | (a value sumNumbers: #tally) > (b value sumNumbers: #tally) ].
			diag := (ESVerticalBarDiagram new)
				identifier: [:each | each key ];
				y: [:each | each value size];
				yAxisLabel: 'Activations';
				valueAxis;
				rightYAxis;
				defaultColor: Color veryLightGray;
				axisColor: Color veryLightGray;
				models: grouped;
				rotatedLabels: true;
				yourself.
			diag2 := (ESVerticalBarDiagram new)
				y: [:each | each value sum: #tally];
				regularAxis;
				yAxisLabel: 'Local duration (ms)';
				gapFraction: 2 / 3;
				defaultColor: (Color fromString: '365d86');
				axisColor: (Color fromString: '365d86');
				models: grouped;
				yourself.
			(renderer compositeDiagram)
				add: diag;
				add: diag2;
				height: 400;
				width: 600 ] 
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ self method gtInspectorSourceIn: composite
]
