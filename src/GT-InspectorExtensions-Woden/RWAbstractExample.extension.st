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
		send: [ :example | example ];
		painting: [ :view | 
			self gtOpenOn: view ]
]
