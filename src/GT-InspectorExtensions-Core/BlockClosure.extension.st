Extension { #name : #BlockClosure }

{ #category : #'*GT-InspectorExtensions-Core' }
BlockClosure class >> gtExampleEmpty [
	<example: 'Empty'>
	^ [  ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
BlockClosure class >> gtExampleOneArgument [
	<example: 'With one argument'>
	^ [ :x | x ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
BlockClosure class >> gtExampleTwoArguments [
	<example: 'With two arguments'>
	^ [ :x :y | x + y ]
]

{ #category : #'*GT-InspectorExtensions-Core' }
BlockClosure >> gtInspectorSourceCodeIn: composite [ 
	<gtInspectorPresentationOrder: 40>
	self sourceNode gtInspectorSourceCodeIn: composite
]
