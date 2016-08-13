Class {
	#name : #GTDummyExamplesWithContext,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #'as yet unclassified' }
GTDummyExamplesWithContext class >> a [
	<gtExample>
	self assert: self gtExampleContext notNil.
	self gtExampleContext at: #a put: #a.
	^ self gtExampleContext 
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithContext class >> b: a c: c [
	<gtExample>
	<depends: #a>
	<depends: #c>
	self assert: self gtExampleContext notNil.
	self assert: a == self gtExampleContext.
	self assert: c == self gtExampleContext.
	self assert: (self gtExampleContext at: #a) = #a.
	self assert: (self gtExampleContext at: #c) = #c.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithContext class >> c [
	<gtExample>
	self assert: self gtExampleContext notNil.
	self gtExampleContext at: #c put: #c.
	^ self gtExampleContext 
]
