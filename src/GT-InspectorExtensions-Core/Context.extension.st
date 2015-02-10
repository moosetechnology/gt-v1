Extension { #name : #Context }

{ #category : #'*GT-InspectorExtensions-Core' }
Context >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 30> 
	self method gtInspectorSourceIn: composite
]

{ #category : #'*GT-InspectorExtensions-Core' }
Context >> gtInspectorVariableValuePairs [
	"We override the variables with context specific ones"
	| superVariableValuePairs tempVariableValuePairs tempIndex |
	tempIndex := 0. 
	superVariableValuePairs := super gtInspectorVariableValuePairs.
	tempVariableValuePairs := (self tempNames
						collect: [ :tempName ||value|
							tempIndex := tempIndex + 1.
							value := [self debuggerMap namedTempAt: tempIndex in: self] 
								on: Error 
								do: [value := (Text string: 'error obtaining field value' attribute: TextColor red) asString ].
							('[' , tempName , ']') -> value ]) sort asOrderedCollection.
		^ tempVariableValuePairs addAll: superVariableValuePairs; yourself
]

{ #category : #'*GT-InspectorExtensions-Core' }
Context class >> thisContextExample [
	<example: 'thisContext'>
	^ thisContext
]
