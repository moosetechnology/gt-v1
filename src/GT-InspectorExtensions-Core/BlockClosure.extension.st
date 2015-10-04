Extension { #name : #BlockClosure }

{ #category : #'*GT-InspectorExtensions-Core' }
BlockClosure class >> gtExampleEmpty [
	<gtExample>
	<label: 'Empty'>
	
	^ [  ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
BlockClosure class >> gtExampleOneArgument [
	<gtExample>
	<label: 'With one argument'>
	
	^ [ :x | x ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
BlockClosure class >> gtExampleTwoArguments [
	<gtExample>
	<label: 'With two arguments'>
	
	^ [ :x :y | x + y ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
BlockClosure >> gtInspectorSourceCodeIn: composite [ 
	<gtInspectorPresentationOrder: 40>
	self sourceNode gtInspectorSourceCodeIn: composite
]
