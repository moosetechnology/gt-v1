Extension { #name : #CPQualitative }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPQualitative classSide >> gtExample [
	<gtExample: 'Colors: qualititive scheme'>
	^ CPQualitative new
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
CPQualitative >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal2
		title: 'View';
		painting: [ :view | self viewOn: view ]
]
