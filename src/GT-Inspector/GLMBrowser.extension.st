Extension { #name : #GLMBrowser }

{ #category : #'*gt-inspector' }
GLMBrowser >> gtInspectorBrowserIn: composite [
	<gtInspectorPresentationOrder: 40>  
	^ (composite wrapper with: [ :w |
		w title: 'Live'.
		w show: [:a | a custom: self copy ] ]
		) startOn: self entity
]

{ #category : #'*gt-inspector' }
GLMBrowser >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ composite roassal 
		title: 'Tree';
		painting: [:view :b | 
			self viewTreeOn: view ]
]
