Extension { #name : #PRDocumentItem }

{ #category : #'*GT-InspectorExtensions-Pillar' }
PRDocumentItem >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite text 
		title: 'Text';
		display: [ self text ]
]
