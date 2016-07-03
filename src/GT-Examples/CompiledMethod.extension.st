Extension { #name : #CompiledMethod }

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> asGTExampleSubject [
	^ GTExampleMethodSubject new 
		subjectClass: self methodClass;
		subjectSelector: self selector;
		yourself
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> gtExample [
	self gtExamplesFactory exampleMethod: self do: [ :example | ^ example ].
	^ nil
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
CompiledMethod >> isGTExampleMethod [
	^ self pragmas anySatisfy: [ :each | each isGTExamplePragma ]
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> valueWithReceiver: aReceiver possibleArguments: anArray [ 
	^ anArray size = self numArgs 
		ifTrue: [ self valueWithReceiver: aReceiver arguments: anArray  ]
		ifFalse: [ self valueWithReceiver: aReceiver arguments: (anArray copyFrom: 1 to: self numArgs) ]
]
