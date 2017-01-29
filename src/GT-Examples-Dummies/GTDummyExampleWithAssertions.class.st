Class {
	#name : #GTDummyExampleWithAssertions,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

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
	<dependsOn: #a>
	<dependsOn: #b>
	self assert: aBoolean = anotherBoolean.
	^ aBoolean & anotherBoolean
]
