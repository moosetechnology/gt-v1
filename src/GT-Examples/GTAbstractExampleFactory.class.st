Class {
	#name : #GTAbstractExampleFactory,
	#superclass : #Object,
	#instVars : [
		'cache',
		'source',
		'provider',
		'exampleClass'
	],
	#category : #'GT-Examples-Organization'
}

{ #category : #accessing }
GTAbstractExampleFactory >> cache [
	^ cache ifNil: [ cache := self defaultCache ]
]

{ #category : #accessing }
GTAbstractExampleFactory >> cache: anObject [
	^ cache := anObject
]

{ #category : #'private-utils' }
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
GTAbstractExampleFactory >> defaultExampleClass [
	^ self subclassResponsibility
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

{ #category : #'private-init' }
GTAbstractExampleFactory >> initializeExample: aGTExample fromMethod: aCompiledMethod [
]

{ #category : #'private-init' }
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

{ #category : #'private-init' }
GTAbstractExampleFactory >> initializePragmasFromMethod: aCompiledMethod forExample: aGTExample [
	self initializePragmas: aCompiledMethod pragmas forExample: aGTExample
]

{ #category : #'private-init' }
GTAbstractExampleFactory >> initializeSubjects: aCollection forExample: aGTExample [
	aCollection isEmptyOrNil ifTrue: [ ^ self ].
	
	aCollection do: [ :subject | 
		[ aGTExample addSubject: subject ]
			on:Error
			do: [ :exception | 
				aGTExample addProblem: (GTExampleSubjectError new 
					example: aGTExample;
					subject: subject;
					signaledException: exception;
					yourself) ] ] 
]

{ #category : #'private-init' }
GTAbstractExampleFactory >> initializeSubjectsForMethod: aCompiledMethod forExample: aGTExample [
	[ self providerFor: aCompiledMethod do: [ :each | 
			(each class canPerform: #gtExamplesSubjects) ifTrue: [
				self initializeSubjects: each gtExamplesSubjects forExample: aGTExample ] ] ]
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

{ #category : #'private-utils' }
GTAbstractExampleFactory >> providerFor: aCompiledMethod [
	^ provider ifNil: [ self defaultProviderFor: aCompiledMethod ]
]

{ #category : #'private-utils' }
GTAbstractExampleFactory >> providerFor: aCompiledMethod do: aBlock1 [
	^ self providerFor: aCompiledMethod do: aBlock1 ifNone: nil
]

{ #category : #'private-utils' }
GTAbstractExampleFactory >> providerFor: aCompiledMethod do: aBlock1 ifNone: aBlock2 [
	^ (self providerFor: aCompiledMethod) 
		ifNotNilDo: aBlock1
		ifNil: aBlock2
]

{ #category : #accessing }
GTAbstractExampleFactory >> source [
	^ source
]

{ #category : #accessing }
GTAbstractExampleFactory >> source: anObject [
	source := anObject
]
