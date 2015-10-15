Class {
	#name : #GTDummyExampleWithAssertions,
	#superclass : #TestCase,
	#category : #'GT-Inspector-Examples-Dummies-2'
}

{ #category : #'as yet unclassified' }
GTDummyExampleWithAssertions class >> gtExamplesProvider [
	^ self new
]

{ #category : #examples }
GTDummyExampleWithAssertions >> a [
	<gtExample>
	^ true
]

{ #category : #examples }
GTDummyExampleWithAssertions >> b [
	<gtExample>
	^ true
]

{ #category : #examples }
GTDummyExampleWithAssertions >> c: aBoolean c: anotherBoolean [
	<gtExample>
	<depends: #a>
	<depends: #b>
	self assert: aBoolean equals: anotherBoolean.
	^ aBoolean & anotherBoolean
]
