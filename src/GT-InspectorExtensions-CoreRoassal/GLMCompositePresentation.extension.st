Extension { #name : #GLMCompositePresentation }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
GLMCompositePresentation >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ composite roassal 
		title: 'Tree';
		painting: [:view :b | 
			self viewTreeOn: view ]
]
