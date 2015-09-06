Extension { #name : #CompiledMethod }

{ #category : #'*GT-Inspector-Examples-Core' }
CompiledMethod >> gtExamples [
	| examples |
	examples := OrderedCollection new.
	self methodClass theNonMetaClass gtExamplesFinder method: self to: examples.
	^ examples
]
