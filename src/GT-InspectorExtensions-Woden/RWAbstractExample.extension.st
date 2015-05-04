Extension { #name : #RWAbstractExample }

{ #category : #'*GT-InspectorExtensions-Woden' }
RWAbstractExample >> gtDisplayExamplesIn: aComposite [

	^ (self gtInspectorPreviewIn: aComposite)
		title: 'E.g'
]

{ #category : #'*GT-InspectorExtensions-Woden' }
RWAbstractExample >> gtInspectorPreviewIn: composite [
	<gtInspectorPresentationOrder: 4>
	^ composite roassal2
		title: 'Examples';
		when: [ self gtExamples notEmpty ];
		send: [ :example | example result ];
		painting: [ :view | 
			view @ RTDraggableView.
			self gtOpenOn: view ]
]
