Extension { #name : #RTAbstractExample }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTAbstractExample classSide >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 4>
	^ self new gtInspectorPreviewIn: composite
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTAbstractExample >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 4>
	composite roassal2
		title: 'Example';
		painting: [ :view | 
			view @ RTDraggableView.
			self gtOpenOn: view ]
]
