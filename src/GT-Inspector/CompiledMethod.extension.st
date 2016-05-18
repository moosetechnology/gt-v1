Extension { #name : #CompiledMethod }

{ #category : #'*GT-Inspector-Examples-Core' }
CompiledMethod >> gtExampleValue [
	^ self gtExamples 
		ifNotEmpty: [ :examples | 
			" there should only be one example per compiled-method, otherwise something is really messed up "
			self assert: examples size = 1. 
			examples first returnValue ] 
		ifEmpty: [ self error: self printString, ' does not define an example' ]
]

{ #category : #'*GT-Inspector-Examples-Core' }
CompiledMethod >> gtExamples [
	| examples |
	examples := OrderedCollection new.
	self methodClass theNonMetaClass gtExamplesFinder method: self to: examples.
	^ examples
]
