Extension { #name : #Class }

{ #category : #'*gt-inspectorextensions-code' }
Class >> gtInspectorMethodsAttractionIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite roassal 
		title: 'Methods attraction';
		painting: [ :view | 
			view shape ellipse withoutBorder; fillColor: Color gray.
			view nodes: self methods.
			view edgesToAll: [ :each |
				each parseTree allChildren 
					select: [ :n | n isMessage and: [ n isSelfSend and: [ self methods anySatisfy: [ :m | m selector = n selector ] ] ] ]
					thenCollect: [ :n | self methods detect: [:m | m selector = n selector ] ]].
			view setEdgesAttachPoint: ROCenteredAttachPoint.
			view layout: ROForceBasedLayout.
			 ]
]
