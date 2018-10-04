Extension { #name : #RGMethodDefinition }

{ #category : #'*GT-Examples-Examples' }
RGMethodDefinition class >> gtExampleMethod [
	<gtExample>
	<label: 'RMethodDefinition'>
	
	^ (GTInspector class >> #gtInspectorExtensionsIn:) asRingDefinition
]
