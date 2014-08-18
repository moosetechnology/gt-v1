Extension { #name : #RTAbstractExample }

{ #category : #'*GT-InspectorExtensions-Core' }
RTAbstractExample >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 4>
	composite roassal2
		title: 'Example';
		painting: [ :view | self openOn: view ]
]
