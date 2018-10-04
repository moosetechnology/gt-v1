Class {
	#name : #GTDummyExampleProvider,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

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
	<dependsOn: #a>
	<dependsOn: #b>
	^ a | b
]
