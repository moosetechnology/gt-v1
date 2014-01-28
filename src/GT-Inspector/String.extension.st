Extension { #name : #String }

{ #category : #'*gt-inspector' }
String class >> gtInspectorFourtyTwo [
	<gtExample>
	^ '42'
]

{ #category : #'*gt-inspector' }
String >> gtInspectorItemsIn: composite [
	"No items presentation for a String"
]

{ #category : #'*gt-inspector' }
String >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 30>  
	 composite text
		title: 'String'
]
