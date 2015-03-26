Extension { #name : #String }

{ #category : #'*GT-InspectorExtensions-Core' }
String class >> gtInspectorFourtyTwo [
	<gtExample>
	^ '42'
]

{ #category : #'*GT-InspectorExtensions-Core' }
String >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: -10>  
	 composite rubricText
		title: 'String'
]
