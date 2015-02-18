Extension { #name : #MessageSend }

{ #category : #'*GT-SpotterExtensions-Core' }
MessageSend >> gtSpotterExpression: someArguments [
	^ self glamourValueWithArgs: someArguments
]
