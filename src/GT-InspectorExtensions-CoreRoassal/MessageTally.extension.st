Extension { #name : #MessageTally }

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
