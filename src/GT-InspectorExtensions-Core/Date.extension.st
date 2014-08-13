Extension { #name : #Date }

{ #category : #'*GT-InspectorExtensions-Core' }
Date >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite morph
		title: 'Preview';
		morph: [ CalendarMorph on: self ]
]
