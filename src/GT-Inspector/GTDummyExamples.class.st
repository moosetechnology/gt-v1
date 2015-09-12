Class {
	#name : #GTDummyExamples,
	#superclass : #Object,
	#category : #'GT-Inspector-Examples-Dummies'
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
	<depends: #a>
	
	^ aBoolean & false
]

{ #category : #examples }
GTDummyExamples class >> c: aBoolean [
	<gtExample>
	<label: 'Dummy #c:, depends #b:'>
	<description: 'should return true'>
	<depends: #b:>
	
	^ aBoolean | true
]

{ #category : #examples }
GTDummyExamples class >> d: anInteger [
	<gtExample>
	<label: 'Dummy #d:, depends #c:'>
	<description: 'should raise an exception as the argument is not anInteger'>
	<depends: #c:>
	<raises: MessageNotUnderstood>
	
	^ 1 + anInteger
]

{ #category : #examples }
GTDummyExamples class >> e: aString [
	<gtExample>
	<label: 'Dummy #e:, depends #c:'>
	<description: 'should raise an exception as the argument is not aString'>
	<depends: #c:>
	<raises: Error>
	
	^ 'Hellow World', aString
]

{ #category : #examples }
GTDummyExamples class >> f: aBoolean [
	<gtExample>
	<label: 'Dummy #f:, depends: #c:'>
	<description: 'shouldnt raise any exception'>
	<depends: #c:>
	
	self assert: aBoolean.
	^ aBoolean
]

{ #category : #examples }
GTDummyExamples class >> g: aBoolean [
	<gtExample>
	<label: 'Dummy #g, depends: #c'>
	<description: 'should raise a ZeroDivide'>
	<depends: #c:>
	<raises: ZeroDivide>
	
	self assert: aBoolean.
	^ 1/0
]

{ #category : #'examples-failing' }
GTDummyExamples class >> h: aBoolean [
	<gtExample>
	<label: 'Dummy #h, depends: #e:'>
	<description: 'shouldnt raise any exception, but dependency should'>
	<depends: #e:>
	
	^ aBoolean & false
]

{ #category : #examples }
GTDummyExamples class >> i [
	<gtExample>
	<label: 'Dummy #i'>
	<description: 'should raise ZeroDivide'>

	<raises: ZeroDivide>
	^ 1/0
]

{ #category : #examples }
GTDummyExamples class >> j [
	<gtExample>
	<label: 'Dummy #j'>
	<description: 'should raise ZeroDivide'>
	<raises: ZeroDivide>
	<raises: AssertionFailure>

	1/0.	
	self assert: false
]

{ #category : #examples }
GTDummyExamples class >> k [
	<gtExample>
	<label: 'Dummy #k'>
	<description: 'example with an icon'>
	<icon: #alertIcon>

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
	<depends: #a>
	<depends: #b:>
	<depends: #c:>
	
	self assert: (aBoolean1 | aBoolean2 | aBoolean3).
	^ aBoolean1 | aBoolean2 | aBoolean3
]

{ #category : #examples }
GTDummyExamples class >> q: aBoolean [
	<gtExample>
	<description: 'with description only'>
	<depends: #p:p:p:>
	
	self assert: aBoolean.
	^ aBoolean
]

{ #category : #examples }
GTDummyExamples class >> r: aBoolean1 r: aBoolean2 [
	<gtExample>
	<label: 'Dummy #r:, depends #q: and p:p:p:'>
	<depends: #p:p:p:>
	<depends: #q:>
	
	self assert: aBoolean1 & aBoolean2.
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples-failing' }
GTDummyExamples class >> s: aBoolean [
	<gtExample>
	<label: 'Dummy #s, invalid recursion'>
	<depends: #s:>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> t: aBoolean [
	<gtExample>
	<label: 'Dummy #s, invalid recursion'>
	<depends: #s:>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> u: aBoolean [
	<gtExample>
	<label: 'Dummy #u, invalid recursion'>
	<depends: #v:>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> v: aBoolean [
	<gtExample>
	<label: 'Dummy #v, invalid recursion'>
	<depends: #u:>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> w: aBoolean [
	<gtExample>
	<label: 'Dummy #w'>
	<depends: #z:>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> x: aBoolean [
	<gtExample>
	<label: 'Dummy #x:, depends: w:'>
	<depends: #w:>
	
	^ aBoolean
]

{ #category : #'examples-failing' }
GTDummyExamples class >> y: aBoolean1 y: aBoolean2 [
	<gtExample>
	<label: 'Dummy #y:y:, depends: #x: and #w:'>
	<depends: #x:>
	<depends: #w:>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples-failing' }
GTDummyExamples class >> z: aBoolean [
	<gtExample>
	<label: 'Dummy #z, depends: #y:y:'>
	<depends: #y:y:>
	
	^ aBoolean
]
