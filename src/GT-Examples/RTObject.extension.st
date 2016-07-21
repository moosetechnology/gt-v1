Extension { #name : #RTObject }

{ #category : #'*GT-Examples-TODO' }
RTObject classSide >> gtExamplesFactory [
	^ RTExampleFactory new
		source: self;
		yourself
]
