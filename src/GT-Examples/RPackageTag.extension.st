Extension { #name : #RPackageTag }

{ #category : #'*GT-Examples-Core' }
RPackageTag >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self package methods do: [ :method |
		examples addAll: method gtExamples ].
	^ examples
]
