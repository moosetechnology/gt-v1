Extension { #name : #Context }

{ #category : #'*GT-Examples-Core' }
Context class >> gtExamplesFactory [
	^ super gtExamplesFactory
		provider: self class;
		yourself
]
