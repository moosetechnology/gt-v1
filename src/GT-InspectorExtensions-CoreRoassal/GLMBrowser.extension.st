Extension { #name : #GLMBrowser }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
GLMBrowser >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ composite roassal2
		title: 'Tree';
		painting: [:view :b | 
			self viewTreeOn: view ]
]
