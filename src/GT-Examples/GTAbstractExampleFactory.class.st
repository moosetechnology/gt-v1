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

{ #category : #private }
GTAbstractExampleFactory >> createExample: aCompiledMethod [
	| example |
	example := self exampleClass new.
	self initializeFromMethod: aCompiledMethod forExample: example.
	^example
]

{ #category : #'accessing-defaults' }
GTAbstractExampleFactory >> defaultCache [
	^ GTExampleOrganizer instance
]

{ #category : #'accessing-defaults' }
GTAbstractExampleFactory >> defaultProvider [
	^ self source isMeta
		ifTrue: [ self source ]
		ifFalse: [ self source basicNew " this might not work for all sources ! " ]
]

{ #category : #'accessing-defaults' }
GTAbstractExampleFactory >> defaultSelectorsProvidingSubjects [
	^ self source methods select: [ :each | 
		each pragmas anySatisfy: [ :pragma | 
			pragma keyword = #gtExamplesSubjects ] ]
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

{ #category : #private }
GTAbstractExampleFactory >> initializeFromMethod: aCompiledMethod forExample: aGTExample [
	aGTExample methodClass: aCompiledMethod methodClass.
	aGTExample selector: aCompiledMethod selector.
]

{ #category : #private }
GTAbstractExampleFactory >> initializePragmasFromMethod: aCompiledMethod forExample: aGTExample [
	aCompiledMethod pragmas do: [ :pragma | 
		(aGTExample class canPerform: pragma keyword) ifTrue: [ 
			[ aGTExample perform: pragma keyword withArguments: pragma arguments ]
				on:Error
				do:[ :exception | 
					aGTExample addProblem: (exception asGTExamplePragmaError 
						example: aGTExample;
						pragma: pragma;
						yourself) ] ] ]
]

{ #category : #private }
GTAbstractExampleFactory >> initializeSubjects: aCollection forExample: aGTExample [
	aCollection isEmptyOrNil ifTrue: [ ^ self ].
	
	aCollection do: [ :subject | 
		[ aGTExample subjects add: subject asGTExampleSubject ]
			on:Error
			do: [ :exception | 
				aGTExample failures add: (GTExampleSubjectError new 
					example: aGTExample;
					subject: subject;
					signaledException: exception;
					yourself) ] ] 
]

{ #category : #private }
GTAbstractExampleFactory >> initializeSubjectsFromPragma: aProvider forExample: aGTExample [
	[ self selectorsProvidingSubjects do: [ :each |
			self initializeSubjects: (aProvider perform: each) forExample: aGTExample ] ]
		on: Error
		do: [ :exception | 
			aGTExample failures add: (GTExampleSubjectError new 
				example: aGTExample;
				signaledException: exception;
				yourself) ]
]

{ #category : #private }
GTAbstractExampleFactory >> initializeSubjectsFromSelector: aProvider forExample: aGTExample [
	[ (aProvider class includesSelector: #gtExamplesSubjects) ifTrue: [
			self initializeSubjects: aProvider gtExamplesSubjects forExample: aGTExample ] ]
		on: Error
		do: [ :exception | 
			aGTExample failures add: (GTExampleSubjectError new 
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
	^ provider ifNil: [ provider := self defaultProvider ]
]

{ #category : #accessing }
GTAbstractExampleFactory >> provider: anObject [
	provider := anObject
]

{ #category : #private }
GTAbstractExampleFactory >> selectorsProvidingSubjects [
	^ selectorProvidingSubjects ifNil: [ selectorProvidingSubjects := self defaultSelectorsProvidingSubjects ]
]

{ #category : #accessing }
GTAbstractExampleFactory >> source [
	^ source
]

{ #category : #accessing }
GTAbstractExampleFactory >> source: anObject [
	source := anObject
]
