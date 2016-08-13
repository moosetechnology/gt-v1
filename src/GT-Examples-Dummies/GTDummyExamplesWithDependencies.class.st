Class {
	#name : #GTDummyExamplesWithDependencies,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #examples }
GTDummyExamplesWithDependencies class >> a [
	<gtExample>
	<label: 'Dummy #a'>
	<description: 'Dummy #a'>
	
	^ true
]

{ #category : #examples }
GTDummyExamplesWithDependencies class >> b: aBoolean [
	<gtExample>
	<label: 'Dummy #b:'>
	<description: 'Dummy #b:, depends: #a'>
	<depends: #a> " aBoolean "
	
	^ aBoolean
]

{ #category : #examples }
GTDummyExamplesWithDependencies class >> c: aBoolean1 c: aBoolean2 [
	<gtExample>
	<label: 'Dummy #c:c:'>
	<description: 'Dummy #c:c:, depends: #a and #b:'>
	<depends: #a> " aBoolean1 "
	<depends: #b:> " aBoolean2 "
	
	^ aBoolean1 & aBoolean2
]

{ #category : #examples }
GTDummyExamplesWithDependencies class >> d: aBoolean1 d: aBoolean2 d: aBoolean3 [
	<gtExample>
	<label: 'Dummy #d:d:d:'>
	<description: 'Dummy #d:d:d:, depends: #a and #b: and #c:c:'>
	<depends: #a> " aBoolean1 "
	<depends: #b:> " aBoolean2 "
	<depends: #c:c:> " aBoolean3 "
	
	^ aBoolean1 & aBoolean2 & aBoolean3
]

{ #category : #examples }
GTDummyExamplesWithDependencies class >> e: aBoolean1 e: aBoolean2 e: aBoolean3 e: aBoolean4 [
	<gtExample>
	<label: 'Dummy #e:e:e:e:'>
	<description: 'Dummy #e:e:e:e:, depends: #a and #b: and #c:c: and #d:d:d:'>
	<depends: #a> " aBoolean1 "
	<depends: #b:> " aBoolean2 "
	<depends: #c:c:> " aBoolean3 "
	<depends: #d:d:d:> " aBoolean4 "
	
	^ aBoolean1 & aBoolean2 & aBoolean3 & aBoolean4
]

{ #category : #examples }
GTDummyExamplesWithDependencies class >> f: aBoolean1 f: aBoolean2 f: aBoolean3 [
	" to have the same dependency more than once probably makes no sense at all, but it is technically valid. We don't make any constraints "
	<gtExample>
	<label: 'Dummy #f:f:f:'>
	<description: 'Dummy #f:f:f:, depends: #a and #a and #a'>
	<depends: #a> " aBoolean1 "
	<depends: #a> " aBoolean2 "
	<depends: #a> " aBoolean3 "
	
	^ aBoolean1 & aBoolean2 & aBoolean3
]

{ #category : #examples }
GTDummyExamplesWithDependencies class >> g: aBoolean1 g: aBoolean2 g: aBoolean3 [
	<gtExample>
	<label: 'Dummy #g:g:g:'>
	<description: 'Dummy #g:g:g:, depends: #a and #e:e:e:e: and #d:d:d:'>
	<depends: #a> " aBoolean1 "
	<depends: #e:e:e:e:> " aBoolean2 "
	<depends: #d:d:d:> " aBoolean3 "
	
	^ aBoolean1 & aBoolean2 & aBoolean3
]
