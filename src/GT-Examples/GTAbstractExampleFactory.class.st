Class {
	#name : #GTAbstractExampleFactory,
	#superclass : #Object,
	#instVars : [
		'cache',
		'source',
		'provider',
		'exampleClass',
		'selectorProvidingSubjects'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #accessing }
GTAbstractExampleFactory >> cache [
	^ cache ifNil: [ cache := self defaultCache ]
]

{ #category : #accessing }
GTAbstractExampleFactory >> cache: anObject [
	^ cache := anObject
]

{ #category : #'private - creating examples' }
GTAbstractExampleFactory >> createExample: aCompiledMethod [
	^ self exampleClass new
		initializeFromMethod: aCompiledMethod usingFactory: self;
		yourself
]

{ #category : #'accessing-defaults' }
GTAbstractExampleFactory >> defaultCache [
	^ GTExampleOrganizer instance
]

{ #category : #'accessing-defaults' }
GTAbstractExampleFactory >> defaultProviderFor: aCompiledMethod [ 
	^ aCompiledMethod methodClass isMeta
		ifTrue: [ aCompiledMethod methodClass theNonMetaClass ]
		ifFalse: [ aCompiledMethod methodClass theNonMetaClass new " WARNING: not all classes support this -> override this using: #provider: " ] 
]

{ #category : #private }
GTAbstractExampleFactory >> exampleAt: aCompiledMethod ifAbsentPut: aBlock [
	^ aBlock value
]

{ #category : #accessing }
GTAbstractExampleFactory >> exampleClass [
	^ exampleClass ifNil: [ exampleClass := self defaultExampleClass ]
]

{ #category : #accessing }
GTAbstractExampleFactory >> exampleClass: anObject [
	exampleClass := anObject
]

{ #category : #private }
GTAbstractExampleFactory >> exampleFromMethod: aCompiledMethod do: aBlock [
	aBlock value: (self cache exampleAt: aCompiledMethod ifAbsentPut: [ self createExample: aCompiledMethod ])
]

{ #category : #private }
GTAbstractExampleFactory >> exampleMethod: aCompiledMethod do: aBlock [
	(self isExampleMethod: aCompiledMethod) ifFalse: [ ^ self ].
	self exampleFromMethod: aCompiledMethod do: aBlock
]

{ #category : #private }
GTAbstractExampleFactory >> exampleMethodsDo: aBlock [
	self source theNonMetaClass methods
		select: [ :each | self isExampleMethod: each ]
		thenDo: aBlock.
	self source theMetaClass methods
		select: [ :each | self isExampleMethod: each ]
		thenDo: aBlock.
		
]

{ #category : #private }
GTAbstractExampleFactory >> examplesDo: aBlock [
	self exampleMethodsDo: [ :method |
		self exampleFromMethod: method do: aBlock ]
]

{ #category : #public }
GTAbstractExampleFactory >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self examplesDo: [ :example | examples add: example ].
	^ examples
]

{ #category : #'private - creating examples' }
GTAbstractExampleFactory >> initializeExample: aGTExample fromMethod: aCompiledMethod [
]

{ #category : #'private - creating examples' }
GTAbstractExampleFactory >> initializePragmas: aCollection forExample: aGTExample [
	aCollection do: [ :pragma | 
		(aGTExample class canPerform: pragma keyword) ifTrue: [ 
			[ aGTExample perform: pragma keyword withArguments: pragma arguments ]
				on:Error
				do:[ :exception | 
					aGTExample addProblem: (GTExamplePragmaError new 
						example: aGTExample;
						pragma: pragma;
						signaledException: exception;
						yourself) ] ] ]
]

{ #category : #'private - creating examples' }
GTAbstractExampleFactory >> initializePragmasFromMethod: aCompiledMethod forExample: aGTExample [
	self initializePragmas: aCompiledMethod pragmas forExample: aGTExample
]

{ #category : #'private - creating examples' }
GTAbstractExampleFactory >> initializeSubjects: aCollection forExample: aGTExample [
	aCollection isEmptyOrNil ifTrue: [ ^ self ].
	
	aCollection do: [ :subject | 
		[ aGTExample addSubject: subject asGTExampleSubject ]
			on:Error
			do: [ :exception | 
				aGTExample addProblem: (GTExampleSubjectError new 
					example: aGTExample;
					subject: subject;
					signaledException: exception;
					yourself) ] ] 
]

{ #category : #'private - creating examples' }
GTAbstractExampleFactory >> initializeSubjectsFromMethod: aCompiledMethod forExample: aGTExample [
	[ 		| tmpProvider |		
			tmpProvider := self providerFor: aCompiledMethod.
			(tmpProvider class canPerform: #gtExamplesSubjects) ifTrue: [
				self initializeSubjects: tmpProvider gtExamplesSubjects forExample: aGTExample ] ]
		on: Error
		do: [ :exception | 
			aGTExample addProblem: (GTExampleSubjectError new 
				example: aGTExample;
				signaledException: exception;
				yourself) ]
]

{ #category : #testing }
GTAbstractExampleFactory >> isExampleMethod: aCompiledMethod [
	self subclassResponsibility
]

{ #category : #testing }
GTAbstractExampleFactory >> isGTExampleMethod: aCompiledMethod [
	^ aCompiledMethod isGTExampleMethod
]

{ #category : #accessing }
GTAbstractExampleFactory >> provider [
	^ provider
]

{ #category : #accessing }
GTAbstractExampleFactory >> provider: anObject [
	provider := anObject
]

{ #category : #private }
GTAbstractExampleFactory >> providerFor: aCompiledMethod [
	^ provider ifNil: [ self defaultProviderFor: aCompiledMethod ]
]

{ #category : #accessing }
GTAbstractExampleFactory >> selectorProvidingSubjects [
	^ selectorProvidingSubjects
]

{ #category : #accessing }
GTAbstractExampleFactory >> selectorProvidingSubjects: aSelector [
	^ selectorProvidingSubjects := aSelector
]

{ #category : #private }
GTAbstractExampleFactory >> selectorProvidingSubjectsFor: aCompiledMethod [
	^ selectorProvidingSubjects ifNil: [ 
		aCompiledMethod methodClass methods 
			detect: [ :each | 
				each pragmas anySatisfy: [ :pragma | 
					pragma keyword = #gtExamplesSubjects ] ]
			ifNone: [ nil ] ]
]

{ #category : #accessing }
GTAbstractExampleFactory >> source [
	^ source
]

{ #category : #accessing }
GTAbstractExampleFactory >> source: anObject [
	source := anObject
]
