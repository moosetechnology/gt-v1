Extension { #name : #Class }

{ #category : #'*gt-inspector' }
Class >> gtInspectorExamplesIn: composite [
	"This provides a list of example objects for the current class"
	<gtInspectorPresentationOrder: 20>
	composite custom: (GTExamplesBrowser new startOn: self)
]
