Extension { #name : #RPackageTag }

{ #category : #'*GT-Examples-UI' }
RPackageTag >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self methods do: [ :method |
		method gtExamplesFactory exampleMethod: method do: [ :example | 
			examples add: example ] ].
	^ examples
]
