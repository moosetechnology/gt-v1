"
I am not a test! I provide usage examples for the SUnit debugger.
"
Class {
	#name : #GTSUnitExampleWithSetUpAndTearDownTest,
	#superclass : #TestCase,
	#instVars : [
		'a'
	],
	#category : #'GT-SUnitDebugger'
}

{ #category : #testing }
GTSUnitExampleWithSetUpAndTearDownTest class >> isAbstract [
	^ true
]

{ #category : #testing }
GTSUnitExampleWithSetUpAndTearDownTest class >> isUnitTest [
	^ false
]

{ #category : #setup }
GTSUnitExampleWithSetUpAndTearDownTest >> setUp [
	a := 42.
]

{ #category : #setup }
GTSUnitExampleWithSetUpAndTearDownTest >> tearDown [
	a := nil
]

{ #category : #testing }
GTSUnitExampleWithSetUpAndTearDownTest >> testWithErrorInSetup [
	self assert: a equals: 41
]
