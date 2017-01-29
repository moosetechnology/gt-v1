Class {
	#name : #GTDummyExamples,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #examples }
GTDummyExamples class >> a [
	<gtExample>
	<label: 'Dummy #a'>
	<description: 'should return true'>
	
	^ true
]

{ #category : #examples }
GTDummyExamples class >> b: aBoolean [
	<gtExample>
	<label: 'Dummy #b:, depends #a'>
	<description: 'should return false'>
	<dependsOn: #a>
	
	^ aBoolean & false
]

{ #category : #examples }
GTDummyExamples class >> c: aBoolean [
	<gtExample>
	<label: 'Dummy #c:, depends #b:'>
	<description: 'should return true'>
	<dependsOn: #b:>
	
	^ aBoolean | true
]

{ #category : #examples }
GTDummyExamples class >> d: anInteger [
	<gtExample>
	<label: 'Dummy #d:, depends #c:'>
	<description: 'should raise an exception as the argument is not anInteger'>
	<dependsOn: #c:>
	<raises: #MessageNotUnderstood>
	
	^ 1 + anInteger
]

{ #category : #examples }
GTDummyExamples class >> e: aString [
	<gtExample>
	<label: 'Dummy #e:, depends #c:'>
	<description: 'should raise an exception as the argument is not aString'>
	<dependsOn: #c:>
	<raises: #Error>
	
	^ 'Hellow World', aString
]

{ #category : #examples }
GTDummyExamples class >> f: aBoolean [
	<gtExample>
	<label: 'Dummy #f:, depends: #c:'>
	<description: 'shouldnt raise any exception'>
	<dependsOn: #c:>
	
	self assert: aBoolean.
	^ aBoolean
]

{ #category : #examples }
GTDummyExamples class >> g: aBoolean [
	<gtExample>
	<label: 'Dummy #g, depends: #c'>
	<description: 'should raise a ZeroDivide'>
	<dependsOn: #c:>
	<raises: #ZeroDivide>
	
	self assert: aBoolean.
	^ 1/0
]

{ #category : #'examples-failing' }
GTDummyExamples class >> h: aBoolean [
	<gtExample>
	<label: 'Dummy #h, depends: #e:'>
	<description: 'shouldnt raise any exception, but dependency should'>
	<dependsOn: #e:>
	<noTest>
	
	^ aBoolean & false
]

{ #category : #examples }
GTDummyExamples class >> i [
	<gtExample>
	<label: 'Dummy #i'>
	<description: 'should raise ZeroDivide'>

	<raises: #ZeroDivide>
	^ 1/0
]

{ #category : #examples }
GTDummyExamples class >> j [
	<gtExample>
	<label: 'Dummy #j'>
	<description: 'should raise ZeroDivide'>
	<raises: #ZeroDivide>
	<raises: #AssertionFailure>

	1/0.	
	self assert: false
]

{ #category : #examples }
GTDummyExamples class >> k [
	<gtExample>
	<label: 'Dummy #k'>
	<description: 'example with an icon'>
	<icon: #objects>

	^ nil
]

{ #category : #examples }
GTDummyExamples class >> l [
	<gtExample>

]

{ #category : #examples }
GTDummyExamples class >> m [
	<gtExample>
	<label: 'Dummy #m'>

]

{ #category : #examples }
GTDummyExamples class >> n [
	<gtExample>
	<label: 'Dummy #n'>
	<description: 'with label and description'>
]

{ #category : #examples }
GTDummyExamples class >> o [
	<gtExample>
	<description: 'with description only'>
]

{ #category : #examples }
GTDummyExamples class >> p: aBoolean1 p: aBoolean2 p: aBoolean3 [
	<gtExample>
	<label: 'Dummy #p:p:p:, depends #a, #b:, #c:'>
	<description: 'with description only'>
	<dependsOn: #a>
	<dependsOn: #b:>
	<dependsOn: #c:>
	
	self assert: (aBoolean1 | aBoolean2 | aBoolean3).
	^ aBoolean1 | aBoolean2 | aBoolean3
]

{ #category : #examples }
GTDummyExamples class >> q: aBoolean [
	<gtExample>
	<description: 'with description only'>
	<dependsOn: #p:p:p:>
	
	self assert: aBoolean.
	^ aBoolean
]

{ #category : #examples }
GTDummyExamples class >> r: aBoolean1 r: aBoolean2 [
	<gtExample>
	<label: 'Dummy #r:, depends #q: and p:p:p:'>
	<dependsOn: #p:p:p:>
	<dependsOn: #q:>
	
	self assert: aBoolean1 & aBoolean2.
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples-failing' }
GTDummyExamples class >> s: aBoolean [
	<gtExample>
	<label: 'Dummy #s, invalid recursion'>
	<dependsOn: #s:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> t: aBoolean [
	<gtExample>
	<label: 'Dummy #t, invalid recursion'>
	<dependsOn: #s:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> u: aBoolean [
	<gtExample>
	<label: 'Dummy #u, invalid recursion'>
	<dependsOn: #v:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> v: aBoolean [
	<gtExample>
	<label: 'Dummy #v, invalid recursion'>
	<dependsOn: #u:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> w: aBoolean [
	<gtExample>
	<label: 'Dummy #w'>
	<dependsOn: #z:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> x: aBoolean [
	<gtExample>
	<label: 'Dummy #x:, depends: w:'>
	<dependsOn: #w:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> y: aBoolean1 y: aBoolean2 [
	<gtExample>
	<label: 'Dummy #y:y:, depends: #x: and #w:'>
	<dependsOn: #x:>
	<dependsOn: #w:>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples-failing' }
GTDummyExamples class >> z: aBoolean [
	<gtExample>
	<label: 'Dummy #z, depends: #y:y:'>
	<dependsOn: #y:y:>
	<noTest>
	
	^ aBoolean
]
