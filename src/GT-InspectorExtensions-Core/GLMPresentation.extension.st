Extension { #name : #GLMPresentation }

{ #category : #'*GT-InspectorExtensions-Core' }
GLMPresentation class >> exampleBasic [
	<example>
	^ self new
]

{ #category : #'*GT-InspectorExtensions-Core' }
GLMPresentation >> gtInspectorPanePortsIn: composite [
	<gtInspectorPresentationOrder: 50>
	(self pane gtInspectorPortsIn: composite)
		title: 'Pane ports'
]
