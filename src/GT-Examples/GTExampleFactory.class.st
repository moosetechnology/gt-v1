"
I am an internal factory for creating concrete instances of various classes, such as: example,  provider etc.
"
Class {
	#name : #GTExampleFactory,
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
GTExampleFactory >> cache [
	^ cache ifNil: [ cache := self defaultCache ]
]

{ #category : #accessing }
GTExampleFactory >> cache: anObject [
	^ cache := anObject
]

{ #category : #'private-utils' }
GTExampleFactory >> createExample: aCompiledMethod [
	^ self exampleClass new
		initializeFromMethod: aCompiledMethod usingFactory: self;
		yourself
]

{ #category : #'accessing-defaults' }
GTExampleFactory >> defaultCache [
	^ GTExampleOrganizer instance
]

{ #category : #'accessing-defaults' }
GTExampleFactory >> defaultExampleClass [
	^ GTExample
]

{ #category : #'accessing-defaults' }
GTExampleFactory >> defaultProviderFor: aCompiledMethod [ 
	^ aCompiledMethod methodClass isMeta
		ifTrue: [ aCompiledMethod methodClass theNonMetaClass ]
		ifFalse: [ aCompiledMethod methodClass theNonMetaClass new " WARNING: not all classes support this -> override this using: #provider: " ] 
]

{ #category : #private }
GTExampleFactory >> exampleAt: aCompiledMethod ifAbsentPut: aBlock [
	^ aBlock value
]

{ #category : #accessing }
GTExampleFactory >> exampleClass [
	^ exampleClass ifNil: [ exampleClass := self defaultExampleClass ]
]

{ #category : #accessing }
GTExampleFactory >> exampleClass: anObject [
	exampleClass := anObject
]

{ #category : #private }
GTExampleFactory >> exampleFromMethod: aCompiledMethod do: aBlock [
	aBlock value: (self cache exampleAt: aCompiledMethod ifAbsentPut: [ self createExample: aCompiledMethod ])
]

{ #category : #private }
GTExampleFactory >> exampleMethod: aCompiledMethod do: aBlock [
	(self isExampleMethod: aCompiledMethod) ifFalse: [ ^ self ].
	self exampleFromMethod: aCompiledMethod do: aBlock
]

{ #category : #private }
GTExampleFactory >> exampleMethodsDo: aBlock [
	self source theNonMetaClass methods
		select: [ :each | self isExampleMethod: each ]
		thenDo: aBlock.
	self source theMetaClass methods
		select: [ :each | self isExampleMethod: each ]
		thenDo: aBlock.
		
]

{ #category : #private }
GTExampleFactory >> examplesDo: aBlock [
	self exampleMethodsDo: [ :method |
		self exampleFromMethod: method do: aBlock ]
]

{ #category : #public }
GTExampleFactory >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	self examplesDo: [ :example | examples add: example ].
	^ examples
]

{ #category : #'private - creating examples' }
GTExampleFactory >> initializeExample: aGTExample fromMethod: aCompiledMethod [
	self initializeSubjectsForMethod: aCompiledMethod forExample: aGTExample.
	self initializePragmasFromMethod: aCompiledMethod forExample: aGTExample.

]

{ #category : #'private-init' }
GTExampleFactory >> initializePragmas: aCollection forExample: aGTExample [
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
GTExampleFactory >> initializePragmasFromMethod: aCompiledMethod forExample: aGTExample [
	self initializePragmas: aCompiledMethod pragmas forExample: aGTExample
]

{ #category : #'private-init' }
GTExampleFactory >> initializeSubjects: aCollection forExample: aGTExample [
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
GTExampleFactory >> initializeSubjectsForMethod: aCompiledMethod forExample: aGTExample [
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
GTExampleFactory >> isExampleMethod: aCompiledMethod [
	^ self isGTExampleMethod: aCompiledMethod 
]

{ #category : #testing }
GTExampleFactory >> isGTExampleMethod: aCompiledMethod [
	^ aCompiledMethod isGTExampleMethod
]

{ #category : #accessing }
GTExampleFactory >> provider [
	^ provider
]

{ #category : #accessing }
GTExampleFactory >> provider: anObject [
	provider := anObject
]

{ #category : #'private-utils' }
GTExampleFactory >> providerFor: aCompiledMethod [
	^ provider ifNil: [ self defaultProviderFor: aCompiledMethod ]
]

{ #category : #'private-utils' }
GTExampleFactory >> providerFor: aCompiledMethod do: aBlock1 [
	^ self providerFor: aCompiledMethod do: aBlock1 ifNone: nil
]

{ #category : #'private-utils' }
GTExampleFactory >> providerFor: aCompiledMethod do: aBlock1 ifNone: aBlock2 [
	^ (self providerFor: aCompiledMethod)
		ifNotNil: aBlock1
		ifNil: aBlock2
]

{ #category : #accessing }
GTExampleFactory >> source [
	^ source
]

{ #category : #accessing }
GTExampleFactory >> source: anObject [
	source := anObject
]
