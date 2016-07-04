Class {
	#name : #GTDummyExamplesWithExternalDependencies,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Set-1'
}

{ #category : #examples }
GTDummyExamplesWithExternalDependencies class >> a: aBoolean [
	<gtExample>
	<label: 'Dummy #a:'>
	<description: 'Dummy #a:, depends: GTDummyExamples>>#a'>
	<dependsMetaClass: #GTDummyExamples selector: #a> 
	
	^ aBoolean
]

{ #category : #examples }
GTDummyExamplesWithExternalDependencies class >> b: aBoolean1 b: aBoolean2 [
	<gtExample>
	<label: 'Dummy #b:b:'>
	<description: 'Dummy #b:b:, depends: GTDummyExamples>>#a and GTDummyExamples>>#b:'>
	<dependsMetaClass: #GTDummyExamples selector: #a> 
	<dependsMetaClass: #GTDummyExamples selector: #b:> 
	
	^ aBoolean1 & aBoolean2
]

{ #category : #examples }
GTDummyExamplesWithExternalDependencies class >> c: aBoolean1 c: aBoolean2 c: aBoolean3 [
	<gtExample>
	<label: 'Dummy #c:c:'>
	<description: 'Dummy #c:c:c:, depends: GTDummyExamples>>#a and GTDummyExamples>>#b: and GTDummyExamplesWithDependencies>>#a'>
	<dependsMetaClass: #GTDummyExamples selector: #a> 
	<dependsMetaClass: #GTDummyExamples selector: #b:> 
	<dependsMetaClass: 'GTDummyExamplesWithDependencies' selector: #a>
	
	^ aBoolean1 & aBoolean2 & aBoolean3
]
