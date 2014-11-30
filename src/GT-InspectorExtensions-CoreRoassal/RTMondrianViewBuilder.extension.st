Extension { #name : #RTMondrianViewBuilder }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTMondrianViewBuilder classSide >> gtInspectorMondrianExamplesIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ RTMondrianExample new gtInspectorPreviewIn: composite
]
