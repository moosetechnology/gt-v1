Extension { #name : #CPQualitative }

{ #category : #'*GT-Inspector' }
CPQualitative >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self new viewOn: view ]
]
