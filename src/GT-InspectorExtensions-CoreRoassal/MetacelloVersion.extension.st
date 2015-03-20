Extension { #name : #MetacelloVersion }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
MetacelloVersion >> gtInspectorProjectMapIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'Project map';
		initializeView: [ RTMondrian new ];
		painting: [ :view |
			view shape label text: [:each | each asString copyReplaceAll: 'ConfigurationOf' with: ''].
			view nodes: self allProjects.
			view edges
				 connectFrom: #yourself  toAll: [:each | each projects collect: #version].
			view horizontalDominanceTreeLayout layered ]
]
