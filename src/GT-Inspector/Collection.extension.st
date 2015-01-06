Extension { #name : #Collection }

{ #category : #'*GT-Inspector' }
Collection >> gtInspectorInterestingObject [
	^ self size = 1
		ifTrue: [ self anyOne ]
		ifFalse: [ self ]
]

{ #category : #'*GT-Inspector' }
Collection >> gtInspectorVariableValuePairs [
	| pairs index |
	pairs := super gtInspectorVariableValuePairs.
	index := 1.
	self do: [ :each | 
		index > 42 ifTrue: [ ^ pairs ].
		pairs add: (index asTwoCharacterString -> each).
		index := index + 1 ].
	^ pairs
]
