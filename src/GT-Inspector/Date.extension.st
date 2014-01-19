Extension { #name : #Date }

{ #category : #'*gt-inspector' }
Date >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite morph
		title: 'Preview';
		morph: [ CalendarMorph on: self ]
]
