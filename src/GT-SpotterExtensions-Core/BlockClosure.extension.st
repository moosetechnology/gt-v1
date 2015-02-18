Extension { #name : #BlockClosure }

{ #category : #'*GT-SpotterExtensions-Core' }
BlockClosure >> gtSpotterExpression: arguments [
	^ self valueWithPossibleArgs: arguments
]
