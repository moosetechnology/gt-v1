Extension { #name : #CompiledMethod }

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> asGTExampleSubject [
	^ GTExampleMethodSubject new 
		methodClassName: self methodClass theNonMetaClass name;
		methodClass: self methodClass;
		selector: self selector;
		meta: self methodClass isMeta;
		yourself
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
	^ GTExampleFactory new
		source: self methodClass;
		provider: self;
		yourself
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod class >> gtExamplesFactory [
	^ super gtExamplesFactory
		provider: self class;
		yourself
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

{ #category : #'*GT-Examples-UI' }
CompiledMethod >> spotterForExamplesFor: aStep [
	<spotterOrder: 12>
	aStep listProcessor
		title: 'Examples';
		items: [ self gtExamples ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-Core' }
CompiledMethod >> valueWithReceiver: aReceiver possibleArguments: anArray [ 
	^ anArray size = self numArgs 
		ifTrue: [ self valueWithReceiver: aReceiver arguments: anArray  ]
		ifFalse: [ self valueWithReceiver: aReceiver arguments: (anArray copyFrom: 1 to: self numArgs) ]
]
