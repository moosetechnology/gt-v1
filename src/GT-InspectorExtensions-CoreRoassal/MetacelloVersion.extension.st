Extension { #name : #MetacelloVersion }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
MetacelloVersion >> gtInspectorProjectMapIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'Project map';
		initializeView: [ RTMondrianViewBuilder new ];
		painting: [ :view |
			view shape label text: [:each | each asString copyReplaceAll: 'ConfigurationOf' with: ''].
			view nodes: self allProjects.
			view 
				edgesFrom: #yourself 
				toAll: [:each | each projects collect: #version].
			view horizontalDominanceTreeLayout layered ]
]
