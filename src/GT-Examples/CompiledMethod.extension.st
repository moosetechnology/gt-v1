Extension { #name : #CompiledMethod }

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> asGTExampleSubject [
	^ GTExampleMethodSubject fromClass: self methodClass selector: self selector
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> gtExample [
	self gtExamplesFactory exampleMethod: self do: [ :example | ^ example ].
	^ nil
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> gtExampleValue [
	^ self gtExample returnValue
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> gtExamples [
	^ self gtExample 
		ifNotNil: [ :example | { example } ]
		ifNil: [ {  } ]
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> gtExamplesFactory [
	^ self methodClass theNonMetaClass gtExamplesFactory
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> gtValueWithReceiver: aReceiver possibleArguments: anArray [ 
	^ anArray size = self numArgs 
		ifTrue: [ self valueWithReceiver: aReceiver arguments: anArray  ]
		ifFalse: [ self valueWithReceiver: aReceiver arguments: (anArray copyFrom: 1 to: self numArgs) ]
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> isGTExampleMethod [
	^ self pragmas anySatisfy: [ :each | each isGTExamplePragma ]
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> isGTReservedMethod [
	^ #( gtExamplesSubjects gtExamplesFactory gtExample gtExamples ) 
			anySatisfy: [ :selector | selector = self selector ]
]
