Class {
	#name : #GTDummyExamplesInvalid,
	#superclass : #Object,
	#category : #'GT-Inspector-Examples-Dummies-1'
}

{ #category : #examples }
GTDummyExamplesInvalid class >> a: anObject [
	<gtExample>
	<label: 'Dummy #a:'>
	<description: 'argument defined / dependency missing'>
]

{ #category : #examples }
GTDummyExamplesInvalid class >> b [
	<gtExample>
	<label: 'Dummy #b'>
	<description: 'existing dependency defined / argument missing'>
	<depends: #a>
]

{ #category : #examples }
GTDummyExamplesInvalid class >> c: anObject1 c: anObject2 [
	<gtExample>
	<label: 'Dummy #c:c:'>
	<description: 'non-existing dependencies defined, all arguments defined'>
	<depends: #a>
	<depends: #b:>
]

{ #category : #examples }
GTDummyExamplesInvalid class >> d [
	<gtExample>
	<label: 'Dummy #c:c:'>
	<description: 'non-existing dependencies defined, all arguments missing'>
	<depends: #a>
	<depends: #b:>
]
