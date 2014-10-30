"
I can create and initialize a new instance of an example.
"
Class {
	#name : #GTExampleConstructor,
	#superclass : #Object,
	#instVars : [
		'exampleClass'
	],
	#category : #'GT-Inspector-Examples'
}

{ #category : #testing }
GTExampleConstructor >> appliesTo: aMethod [

	self subclassResponsibility 
]

{ #category : #'example creation' }
GTExampleConstructor >> createExampleFor: aMethod [

	self subclassResponsibility 
]

{ #category : #'example creation' }
GTExampleConstructor >> createExampleFrom: aMethod [

	self subclassResponsibility 
]

{ #category : #accessing }
GTExampleConstructor >> defaultExampleClass [

	^ GTExample
]

{ #category : #accessing }
GTExampleConstructor >> exampleClass [

	^ exampleClass
]

{ #category : #accessing }
GTExampleConstructor >> exampleClass: aClass [

	exampleClass := aClass
]

{ #category : #initialize }
GTExampleConstructor >> initialize [
	super initialize.
	
	self exampleClass: self defaultExampleClass
]
