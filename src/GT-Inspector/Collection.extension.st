Extension { #name : #Collection }

{ #category : #'*GT-Inspector' }
Collection >> gtInspectorInterestingObject [
	^ self size = 1
		ifTrue: [ self anyOne ]
		ifFalse: [ self ]
]

{ #category : #'*GT-Inspector' }
Collection >> gtInspectorVariableValuePairs [
	| pairs |
	pairs := super gtInspectorVariableValuePairs.
	self doWithIndex: [ :each :index | 
		index > 42 ifTrue: [ ^ pairs ].
		pairs add: (index asTwoCharacterString -> each) ].
	^ pairs
]
