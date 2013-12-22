Extension { #name : #Text }

{ #category : #'*gt-inspector' }
Text >> gtInspectorItemsIn: composite [
	"No items presentation for a Text"
]

{ #category : #'*gt-inspector' }
Text >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 30>  
	 composite text
		title: 'Text';
		format: self
]
