Class {
	#name : #GTDummyExampleProvider,
	#superclass : #Object,
	#category : #'GT-Inspector-Examples-Dummies-2'
}

{ #category : #'bidirectional-example-linking' }
GTDummyExampleProvider class >> gtExamplesProvider [
	" Notice: this link is MANDATORY "
	" Usecase: All my examples are implemented on the instance side "
	^ self new
]

{ #category : #'bidirectional-example-linking' }
GTDummyExampleProvider class >> gtExamplesSource [
	" Notice: this link is MANDATORY "
	" Usecase: I'm providing all examples for my source since it is probably a really big one and I implement absolutely nothing but examples (and utilities for examples) "
	^ GTDummyExampleSource
]

{ #category : #examples }
GTDummyExampleProvider >> a [
	<gtExample>
	^ GTDummyExampleSource new a " image this example would do something real about its source "
]

{ #category : #examples }
GTDummyExampleProvider >> b [
	<gtExample>
	^ GTDummyExampleSource new b " image this example would do something real about its source "
]

{ #category : #examples }
GTDummyExampleProvider >> c: a c: b [
	<gtExample>
	<depends: #a>
	<depends: #b>
	^ a | b
]
