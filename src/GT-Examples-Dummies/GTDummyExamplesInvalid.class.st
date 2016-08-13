Class {
	#name : #GTDummyExamplesInvalid,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #examples }
GTDummyExamplesInvalid class >> a: anObject [
	<gtExample>
	<label: 'Dummy #a:'>
	<description: 'argument defined / dependency missing'>
	<noTest>
]

{ #category : #examples }
GTDummyExamplesInvalid class >> b [
	<gtExample>
	<label: 'Dummy #b'>
	<description: 'existing dependency defined / argument missing'>
	<depends: #a>
	<noTest>
	
]

{ #category : #examples }
GTDummyExamplesInvalid class >> c: anObject1 c: anObject2 [
	<gtExample>
	<label: 'Dummy #c:c:'>
	<description: 'non-existing dependencies defined, all arguments defined'>
	<depends: #a>
	<depends: #b:>
	<noTest>
	
]

{ #category : #examples }
GTDummyExamplesInvalid class >> d [
	<gtExample>
	<label: 'Dummy #c:c:'>
	<description: 'non-existing dependencies defined, all arguments missing'>
	<depends: #a>
	<depends: #b:>
	<noTest>
	
]

{ #category : #examples }
GTDummyExamplesInvalid class >> e: anObject [
	<gtExample>
	<label: 'Dummy #e:'>
	<description: 'not enough dependencies defined'>
	<depends: #a:>
	<depends: #b>
	<noTest>
	
]

{ #category : #examples }
GTDummyExamplesInvalid class >> f [
	<gtExample>
	<label: 'Dummy #f'>
	<description: 'non existing after method'>
	<after: #afterF> " ! "
	<noTest>
	
]

{ #category : #examples }
GTDummyExamplesInvalid class >> g [
	<gtExample>
	<label: 'Dummy #f'>
	<description: 'non existing after method'>
	<after: nil>
	<noTest>
	
]

{ #category : #testing }
GTDummyExamplesInvalid class >> isExpectedFailure [
	^ true
]
