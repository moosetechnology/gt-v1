Extension { #name : #Character }

{ #category : #'*GT-Examples-Core' }
Character class >> gtExamplesFactory [
	^ super gtExamplesFactory
		provider: self class;
		yourself
]
