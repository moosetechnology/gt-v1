Extension { #name : #Class }

{ #category : #'*GT-SpotterExtensions-Core' }
Class >> spotterAllInstancesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'All instances';
		allCandidates: [ self allInstances ];
		filter: GTFilterSubstring
]
