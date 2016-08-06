Class {
	#name : #GTExampleFactory,
	#superclass : #GTAbstractExampleFactory,
	#category : #'GT-Examples-Utils'
}

{ #category : #'accessing-defaults' }
GTExampleFactory >> defaultExampleClass [
	^ GTExample
]

{ #category : #'private - creating examples' }
GTExampleFactory >> initializeExample: aGTExample fromMethod: aCompiledMethod [
	super initializeExample: aGTExample fromMethod: aCompiledMethod.

	self initializeSubjectsForMethod: aCompiledMethod forExample: aGTExample.
	self initializePragmasFromMethod: aCompiledMethod forExample: aGTExample.

]

{ #category : #testing }
GTExampleFactory >> isExampleMethod: aCompiledMethod [
	^ self isGTExampleMethod: aCompiledMethod 
]
