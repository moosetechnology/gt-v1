Extension { #name : #ContextPart }

{ #category : #'*gt-inspector' }
ContextPart >> gtInspectorRetrieveVariableValuePairs [
	"We override the variables with context specific ones"
	| tempIndex |
	tempIndex := 0.
	^ super gtInspectorRetrieveVariableValuePairs
		addAll:
				(self tempNames
						collect: [ :tempName | 
							tempIndex := tempIndex + 1.
							('[' , tempName , ']') -> (self debuggerMap namedTempAt: tempIndex in: self) ]);
		yourself
]
