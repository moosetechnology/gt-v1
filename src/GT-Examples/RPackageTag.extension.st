Extension { #name : #RPackageTag }

{ #category : #'*GT-Examples-Core' }
RPackageTag >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self package methods do: [ :method |
		method gtExamplesFactory exampleMethod: method do: [ :example | 
			examples add: example ] ].
	^ examples
]
