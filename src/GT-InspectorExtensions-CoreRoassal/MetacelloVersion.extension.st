Extension { #name : #MetacelloVersion }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
MetacelloVersion >> gtInspectorProjectMapIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'Project map';
		initializeView: [ RTMondrian new ];
		painting: [ :view |
			view shape label text: [:each | each asString copyReplaceAll: 'ConfigurationOf' with: ''].
			view nodes: ((self deepCollectAsSet: [ :each | 
								each isNil 
									ifTrue: [ { } ] 
									ifFalse: [ each projects collect: #version ] ])
								reject: #isNil).
			view edges
				 connectFrom: #yourself  toAll: [:each | each projects collect: #version].
			view layout horizontalDominanceTree layered ]
]
