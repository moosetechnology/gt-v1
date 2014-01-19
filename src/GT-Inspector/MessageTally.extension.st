Extension { #name : #MessageTally }

{ #category : #'*gt-inspector' }
MessageTally >> children [
	^ self sonsOver: 0
]

{ #category : #'*gt-inspector' }
MessageTally >> gtDisplayIdentifierOn: aStream [
	class gtDisplayOn: aStream.
	self method methodClass ~~ class 
		ifTrue: [ aStream nextPut: $(; print: self method methodClass; nextPut: $) ].
	aStream 
		nextPutAll: '>>';
		store: self method selector
]

{ #category : #'*gt-inspector' }
MessageTally >> gtDisplayOn: aStream [
	self gtDisplayIdentifierOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self tally printString;
		nextPutAll: ')'
]

{ #category : #'*gt-inspector' }
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

{ #category : #'*gt-inspector' }
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

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorReportIn: composite [
	<gtInspectorPresentationOrder: 60>
	^ composite text
		title: 'Report';
		display: [ String streamContents: [:s | self report: s ] ]
]

{ #category : #'*gt-inspector' }
MessageTally >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ self method ifNotNil: [
		self method gtInspectorSourceIn: composite]
]

{ #category : #'*gt-inspector' }
MessageTally >> localTally [
	^ self children 
		inject: self tally
		into: [ :diff :each | diff - each tally ]
]

{ #category : #'*gt-inspector' }
MessageTally >> localTime [
	^ self children
		inject: self time 
		into: [ :diff :each | diff - each time ]
]
