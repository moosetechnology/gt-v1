Class {
	#name : #GTAbstractExampleFactory,
	#superclass : #Object,
	#instVars : [
		'cache',
		'source',
		'exampleClass'
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

{ #category : #enumeration }
GTAbstractExampleFactory >> exampleMethod: aCompiledMethod do: aBlock [
	(self isExampleMethod: aCompiledMethod) ifFalse: [ ^ self ].
	self exampleFromMethod: aCompiledMethod do: aBlock
]

{ #category : #enumeration }
GTAbstractExampleFactory >> exampleMethodsDo: aBlock [
	self source theNonMetaClass methods
		select: [ :each | self isExampleMethod: each ]
		thenDo: aBlock.
	self source theMetaClass methods
		select: [ :each | self isExampleMethod: each ]
		thenDo: aBlock.
		
]

{ #category : #enumeration }
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
]

{ #category : #private }
GTAbstractExampleFactory >> initializePragmasFromMethod: aCompiledMethod forExample: aGTExample [
	aCompiledMethod pragmas do: [ :pragma | 
		(aGTExample class canPerform: pragma keyword) ifTrue: [ 
			[ aGTExample perform: pragma keyword withArguments: pragma arguments ]
				on:Error
				do:[ :exception | 
					aGTExample failures add: (GTExamplePragmaError new 
						pragma: pragma;
						signaledException: exception;
						yourself) ] ] ]
]

{ #category : #private }
GTAbstractExampleFactory >> initializeSubjectsFromClass: aClass forExample: aGTExample [
	aClass gtExamplesSubjects do: [ :subject | 
		[ aGTExample subjects add: subject asGTExampleSubject ]
			on:Error
			do: [ :exception | 
				aGTExample failures add: (GTExampleSubjectError new 
					signaledException: exception;
					subject: subject;
					yourself) ] ] 
]

{ #category : #testing }
GTAbstractExampleFactory >> isExampleMethod: aCompiledMethod [
	self subclassResponsibility
]

{ #category : #testing }
GTAbstractExampleFactory >> isGTExampleMethod: aCompiledMethod [
	^ (aCompiledMethod pragmas anySatisfy: [ :pragma | pragma isGTExamplePragma ])
]

{ #category : #accessing }
GTAbstractExampleFactory >> source [
	^ source
]

{ #category : #accessing }
GTAbstractExampleFactory >> source: anObject [
	source := anObject
]
