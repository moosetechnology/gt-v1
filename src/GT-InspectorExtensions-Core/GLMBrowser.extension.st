Extension { #name : #GLMBrowser }

{ #category : #'*GT-InspectorExtensions-Core' }
GLMBrowser >> gtInspectorBrowserIn: composite [
	<gtInspectorPresentationOrder: 40>  
	^ (composite wrapper with: [ :w |
		w title: 'Live'.
		w show: [:a | a custom: self copy ] ]
		) startOn: self entity
]

{ #category : #'*GT-InspectorExtensions-Core' }
GLMBrowser >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ composite roassal 
		title: 'Tree';
		painting: [:view :b | 
			self viewTreeOn: view ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
GLMBrowser >> gtInspectorTransmissionsIn: composite [
	<gtInspectorPresentationOrder: 35>  
	^ composite list 
		title: 'Transmissions';
		display: [ self transmissions ]
]
