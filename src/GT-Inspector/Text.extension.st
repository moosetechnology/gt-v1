Extension { #name : #Text }

{ #category : #'*gt-inspector' }
Text >> gtInspectorITextIn: composite [
	<gtInspectorPresentationOrder: 30>  
	 composite text
		title: 'Text';
		format: self
]

{ #category : #'*gt-inspector' }
Text >> gtInspectorItemsIn: composite [
	"We offer the list of characters for a text"
	^ self string gtInspectorItemsIn: composite
]
