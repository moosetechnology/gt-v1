Extension { #name : #Date }

{ #category : #'*GT-InspectorExtensions-Core' }
Date >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite morph
		title: 'Preview';
		morph: [ CalendarMorph on: self ]
]
