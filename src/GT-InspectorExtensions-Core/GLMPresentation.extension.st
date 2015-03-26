Extension { #name : #GLMPresentation }

{ #category : #'*GT-InspectorExtensions-Core' }
GLMPresentation class >> exampleBasic [
	<gtExample>
	^ self new
]

{ #category : #'*GT-InspectorExtensions-Core' }
GLMPresentation >> gtInspectorPanePortsIn: composite [
	<gtInspectorPresentationOrder: 50>
	(self pane gtInspectorPortsIn: composite)
		title: 'Pane ports'
]
