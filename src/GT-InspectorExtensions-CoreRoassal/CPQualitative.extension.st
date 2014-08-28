Extension { #name : #CPQualitative }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPQualitative >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]
