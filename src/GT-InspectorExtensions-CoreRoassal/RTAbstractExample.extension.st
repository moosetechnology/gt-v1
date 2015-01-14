Extension { #name : #RTAbstractExample }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTAbstractExample >> gtDisplayExamplesIn: aComposite [

	^ (self gtInspectorPreviewIn: aComposite)
		title: 'E.g'
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTAbstractExample >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 4>
	^ composite roassal2
		title: 'Examples';
		when: [ self gtExamples notEmpty ];
		send: [ :example | example result ];
		painting: [ :view | 
			view @ RTDraggableView.
			self gtOpenOn: view ]
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTAbstractExample classSide >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 4>
	<gtInspectorTag: #examples>
	^ self new gtInspectorPreviewIn: composite
]
