Class {
	#name : #GTDummyExampleWithAssertions,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
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
	self assert: aBoolean = anotherBoolean.
	^ aBoolean & anotherBoolean
]
