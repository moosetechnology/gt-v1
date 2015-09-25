Extension { #name : #GLMBrowser }

{ #category : #'*GT-InspectorExtensions-Core' }
GLMBrowser class >> gtExampleBasic [
	<gtExample>
	^ GLMWrapper new
]

{ #category : #'*GT-InspectorExtensions-Core' }
GLMBrowser >> gtInspectorTransmissionsIn: composite [
	<gtInspectorPresentationOrder: 35>  
	^ composite list 
		title: 'Transmissions';
		display: [ self transmissions ]
]
