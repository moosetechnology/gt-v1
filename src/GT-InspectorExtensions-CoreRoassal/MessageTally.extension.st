Extension { #name : #MessageTally }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
MessageTally >> gtInspectorMessageTreeIn: composite [
	<gtInspectorPresentationOrder: 40>
	| methods normalizer |
	methods := self withDeepCollect: #children.
	normalizer := RONColorLinearNormalizer 
						inContext: methods 
						withCommand: #tally 
						lowColor: Color gray 
						highColor: Color red.
	^ (composite tree)
		title: 'Tree';
		children: [ :each | each children ];
		"rootsExpanded;"
		format: [ :each | 
			Text 
				string: each gtDisplayString
				attributes: { TextColor color: (normalizer roValue: each)}];
		when: [ self children notEmpty ];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ];
		morphicSelectionAct: [ :list | GTUtils browseMethod: list selection method ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse (b)'
		
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
MessageTally >> gtInspectorPerformanceChartIn: composite [
	<gtInspectorPresentationOrder: 40>
	| metric |
	metric := #localTally.
	^ composite graphET
		title: 'Top tallies';
		diagram: [ :renderer :presentation |
			GTInspectorMessageTallyCharter new 
				performanceOf: self 
				with: renderer 
				in: presentation ];
		when: [ self children notEmpty ]
]
