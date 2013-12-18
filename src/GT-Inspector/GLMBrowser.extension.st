Extension { #name : #GLMBrowser }

{ #category : #'*gt-inspector' }
GLMBrowser >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ composite roassal 
		title: 'Tree';
		painting: [:view :b | 
			self viewTreeOn: view ]
]
