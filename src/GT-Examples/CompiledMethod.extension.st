Extension { #name : #CompiledMethod }

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> gtExample [
	^ self gtExamples 
		ifNotEmpty: [ :examples | 
			" there should only be one example per compiled-method, otherwise something is really messed up "
			self assert: examples size = 1. 
			examples first ]
		ifEmpty: [ self error: self printString, ' does not define any gt-example' ]
]

{ #category : #'*GT-Examples-Convenience' }
CompiledMethod >> gtExampleValue [
	^ self gtExample returnValue
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> gtExamples [
	| examples |
	examples := OrderedCollection new.
	self methodClass theNonMetaClass gtExamplesFinder method: self to: examples.
	^ examples
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> valueWithReceiver: aReceiver possibleArguments: anArray [ 
	^ anArray size = self numArgs 
		ifTrue: [ self valueWithReceiver: aReceiver arguments: anArray  ]
		ifFalse: [ self valueWithReceiver: aReceiver arguments: (anArray copyFrom: 1 to: self numArgs) ]
]
