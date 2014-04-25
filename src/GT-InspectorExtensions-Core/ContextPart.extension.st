Extension { #name : #ContextPart }

{ #category : #'*GT-InspectorExtensions-Core' }
ContextPart >> gtInspectorVariableValuePairs [
	"We override the variables with context specific ones"
	| tempIndex |
	tempIndex := 0.
	^ super gtInspectorVariableValuePairs
		addAll:
				(self tempNames
						collect: [ :tempName | 
							tempIndex := tempIndex + 1.
							('[' , tempName , ']') -> (self debuggerMap namedTempAt: tempIndex in: self) ]);
		yourself
]
