Extension { #name : #RPackage }

{ #category : #'*GT-Examples-Core' }
RPackage >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self methods do: [ :method |
		method gtExamplesFactory exampleMethod: method do: [ :example | 
			examples add: example ] ].
	^ examples
]
