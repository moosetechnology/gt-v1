Class {
	#name : #GTDummyExamplesWithExceptions,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #'examples 1' }
GTDummyExamplesWithExceptions class >> a [
	<gtExample>
	<label: 'Dummy #a'>
	<description: 'Dummy #a, raises ZeroDivide'>
	<raises: #ZeroDivide>
	
	^ 1/0
]

{ #category : #'examples 1' }
GTDummyExamplesWithExceptions class >> b [
	<gtExample>
	<label: 'Dummy #b'>
	<description: 'Dummy #b, raises ZeroDivide'>
	<raises: #ZeroDivide>
	
	^ 1/0
]

{ #category : #'examples 1' }
GTDummyExamplesWithExceptions class >> c [
	<gtExample>
	<label: 'Dummy #c'>
	<description: 'Dummy #c, raises ZeroDivide'>
	<raises: 'ZeroDivide'>
	
	^ 1/0
]

{ #category : #'examples 2' }
GTDummyExamplesWithExceptions class >> d [
	<gtExample>
	<label: 'Dummy #d'>
	<description: 'Dummy #d, raises ZeroDivide or AssertionFailure'>
	<raises: #ZeroDivide>
	<raises: #AssertionFailure>
	
	self assert: #( true false ) atRandom.
	^ 1/0
]

{ #category : #'examples 3' }
GTDummyExamplesWithExceptions class >> e [
	<gtExample>
	<label: 'Dummy #e'>
	<description: 'Dummy #e, raises an unexpected exception (AssertionFailure) since we did not a declare it'>
	<noTest>
	
	self assert: false
]

{ #category : #'examples 3' }
GTDummyExamplesWithExceptions class >> f: anObject [
	<gtExample>
	<label: 'Dummy #f'>
	<description: 'Dummy #f, depends: #b which raises an expected exception, returns nil'>
	<dependsOn: #b>
	
	self assert: anObject isNil
]

{ #category : #'examples 3' }
GTDummyExamplesWithExceptions class >> g: anObject [
	<gtExample>
	<label: 'Dummy #g'>
	<description: 'Dummy #g, depends: #e, should raise a dependency error since the only dependency is raising an exception'>
	<dependsOn: #e>
	<noTest>
	
	^ anObject
]

{ #category : #'examples 3' }
GTDummyExamplesWithExceptions class >> h [
	<gtExample>
	<label: 'Dummy #h'>
	<description: 'Dummy #h, should raise an exception (by declaration) but it does not'>
	<raises: #AssertionFailure>
	<raises: #ZeroDivide>
	<noTest>
	
	self assert: true. " no exception raised -> expected exception not raises"
	true " no exception raised -> expected exception not raises "
		ifTrue: [ ^ 1 ] 
		ifFalse: [ 1/0 ]
]
