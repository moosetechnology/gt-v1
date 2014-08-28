Extension { #name : #FileReference }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
FileReference >> gtInspectorGroupedFilesIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite graphET
		title: 'Grouped files';
		diagram: [ :renderer :presentation |
			| metric all grouped diag diag2|
			metric := #size.
			all := self allFiles.
			grouped := (all groupedBy: [ :each | each extension ]) 
								associations sorted: [:a :b | 
											(a value sumNumbers: metric) > 
											(b value sumNumbers: metric) ].
			grouped := (grouped first: (20 min: grouped size)) select: [:each | (each value sumNumbers: metric) > 0].
			diag := (GETHorizontalBarDiagram new)
				xAxisLabel: 'Number of files';
				modelLabels: [:each | each key ];
				x: [:each | each value size];
				valueAxis;
				color: Color veryLightGray;
				axisColor: Color veryLightGray;
				on: ROMouseClick do: [:event | presentation selection: event model value ];
				models: grouped.
			diag2 := (GETHorizontalBarDiagram new)
				xAxisLabel: 'Total size in MB';
				x: [:each | (each value sumNumbers: metric) / 1000000];
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
				when: [self isDirectory and: [self hasChildren]]
]
