Extension { #name : #ContextPart }

{ #category : #'*gt-inspector' }
ContextPart >> gtInspectorRetrieveVariableValuePairs [
	| tempIndex |
	tempIndex := 0.
	^ super gtInspectorRetrieveVariableValuePairs
		addAll:
				(self tempNames
						collect: [ :tempName | ('[' , tempName , ']') -> (self debuggerMap namedTempAt: (tempIndex := tempIndex + 1) in: self) ]);
		yourself
]
