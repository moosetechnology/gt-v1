Extension { #name : #GLMBrowser }

{ #category : #'*gt-inspector' }
GLMBrowser >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	 composite mondrian 
		title: 'Tree';
		painting: [:view :b | 
			b viewTreeOn: view ]
]
