Extension { #name : #GLMCompositePresentation }

{ #category : #'*gt-inspector' }
GLMCompositePresentation >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ composite roassal 
		title: 'Tree';
		painting: [:view :b | 
			self viewTreeOn: view ]
]
