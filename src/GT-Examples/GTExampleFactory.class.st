Class {
	#name : #GTExampleFactory,
	#superclass : #GTAbstractExampleFactory,
	#category : #'GT-Examples-Utils'
}

{ #category : #'accessing-defaults' }
GTExampleFactory >> defaultExampleClass [
	^ GTExample
]

{ #category : #private }
GTExampleFactory >> initializeFromMethod: aCompiledMethod forExample: aGTExample [
	super initializeFromMethod: aCompiledMethod forExample: aGTExample.
	
	self initializeSubjectsFromSelector: self provider forExample: aGTExample.
	"self initializeSubjectsFromPragma: self provider forExample: aGTExample."
	self initializePragmasFromMethod: aCompiledMethod forExample: aGTExample.

]

{ #category : #testing }
GTExampleFactory >> isExampleMethod: aCompiledMethod [
	^ self isGTExampleMethod: aCompiledMethod 
]
