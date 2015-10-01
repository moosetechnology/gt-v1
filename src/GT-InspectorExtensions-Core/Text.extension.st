Extension { #name : #Text }

{ #category : #'*GT-InspectorExtensions-Core' }
Text class >> gtExampleSimple [
	<gtExample: 'Simple'>
	^ 'fourtytwo' asText
]

{ #category : #'*GT-InspectorExtensions-Core' }
Text >> gtInspectorItemsIn: composite [
	"No items presentation for a Text"
]

{ #category : #'*GT-InspectorExtensions-Core' }
Text >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: -10>  
	 composite text
		title: 'Text';
		format: self
]
