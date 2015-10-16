Extension { #name : #GTExample }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
GTExample >> gtInspectorRoassalIn: composite [
	<gtInspectorPresentationOrder: 1>
	self hasRelationships ifFalse: [ ^ self ].
	^ self painter gtInspectorRoassalIn: composite
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
GTExample >> painter [
	^ GTExamplePainter new 
		example: self;
		yourself
]
