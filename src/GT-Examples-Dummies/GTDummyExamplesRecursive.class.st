Class {
	#name : #GTDummyExamplesRecursive,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #'examples 1' }
GTDummyExamplesRecursive class >> a: aBoolean [
	<gtExample>
	<label: 'Dummy #a:, depends: #a:'>
	<dependsOn: #a:> " loop "
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 1' }
GTDummyExamplesRecursive class >> b: aBoolean [
	<gtExample>
	<label: 'Dummy #b:, depends: #a:'>
	<dependsOn: #a:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 1' }
GTDummyExamplesRecursive class >> c: aBoolean [
	<gtExample>
	<label: 'Dummy #c:, depends: #b:'>
	<dependsOn: #b:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 2' }
GTDummyExamplesRecursive class >> d: aBoolean [
	<gtExample>
	<label: 'Dummy #d:, depends: #f:'>
	<dependsOn: #f:> " loop "
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 2' }
GTDummyExamplesRecursive class >> e: aBoolean [
	<gtExample>
	<label: 'Dummy #e:, depends: #d:'>
	<dependsOn: #d:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 2' }
GTDummyExamplesRecursive class >> f: aBoolean [
	<gtExample>
	<label: 'Dummy #f:, depends: #e:'>
	<dependsOn: #e:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 3' }
GTDummyExamplesRecursive class >> g: aBoolean1 g: aBoolean2 [
	<gtExample>
	<label: 'Dummy #g:g:, depends: #i:i: and #h'>
	<dependsOn: #i:i:>
	<dependsOn: #h>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 3' }
GTDummyExamplesRecursive class >> h [
	<gtExample>
	<label: 'Dummy #h, (the only successful example in this example provider)'>
	<noTest>
	
	^ true
]

{ #category : #'examples 3' }
GTDummyExamplesRecursive class >> i: aBoolean1 i: aBoolean2 [
	<gtExample>
	<label: 'Dummy #i:i:, depends: #j: and #h:'>
	<dependsOn: #j:>
	<dependsOn: #h>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #testing }
GTDummyExamplesRecursive class >> isExpectedRecursion [
	^ true
]

{ #category : #'examples 3' }
GTDummyExamplesRecursive class >> j: aBoolean1 [
	<gtExample>
	<label: 'Dummy #j:, depends: #g:'>
	<dependsOn: #g:g:> " loop "
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 4' }
GTDummyExamplesRecursive class >> k: aBoolean1 k: aBoolean2 [
	<gtExample>
	<label: 'Dummy #k:k:, depends: #m:m: and #l:l:'>
	<dependsOn: #l:l:>
	<dependsOn: #m:m:>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 4' }
GTDummyExamplesRecursive class >> l: aBoolean1 l: aBoolean2 [
	<gtExample>
	<label: 'Dummy #l:l:, depends: #k:k: and #n:'>
	<dependsOn: #k:k:> " loop "
	<dependsOn: #n:>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 4' }
GTDummyExamplesRecursive class >> m: aBoolean1 m: aBoolean2 [
	<gtExample>
	<label: 'Dummy #m:m:, depends: #l:l: and #n:'>
	<dependsOn: #l:l:>
	<dependsOn: #n:>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 4' }
GTDummyExamplesRecursive class >> n: aBoolean1 [
	<gtExample>
	<label: 'Dummy #n:, depends: #k:k:'>
	<dependsOn: #k:k:> " loop "
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 5' }
GTDummyExamplesRecursive class >> o: aBoolean1 [
	<gtExample>
	<label: 'Dummy #o:, depends: #p:'>
	<dependsOn: #p:> 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 5' }
GTDummyExamplesRecursive class >> p: aBoolean1 [
	<gtExample>
	<label: 'Dummy #p:, depends: #o:'>
	<dependsOn: #o:> " loop " 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 6' }
GTDummyExamplesRecursive class >> q: aBoolean1 q: aBoolean2 [
	<gtExample>
	<label: 'Dummy #q:q:, depends: #r: and #r:'>
	<dependsOn: #r:> 
	<dependsOn: #r:> 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 6' }
GTDummyExamplesRecursive class >> r: aBoolean1 [
	<gtExample>
	<label: 'Dummy #r:, depends: #s:'>
	<dependsOn: #s:> 
	<noTest>
		
	^ aBoolean1
]

{ #category : #'examples 6' }
GTDummyExamplesRecursive class >> s: aBoolean1 [
	<gtExample>
	<label: 'Dummy #s:, depends: #q:q:'>
	<dependsOn: #q:q:> " loop " 
	<noTest>
		
	^ aBoolean1
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> t: aBoolean1 t: aBoolean2 [
	<gtExample>
	<label: 'Dummy #t:t:, depends: #u:u: and #v:'>
	<dependsOn: #u:u:> 
	<dependsOn: #v:> 
	<noTest>
		
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> u: aBoolean1 u: aBoolean2 [
	<gtExample>
	<label: 'Dummy #u:u:, depends: #v: and #w:w:'>
	<dependsOn: #w:w:> 
	<dependsOn: #v:> 
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> v: aBoolean1 [
	<gtExample>
	<label: 'Dummy #v:, depends: #x:'>
	<dependsOn: #x:> 
	<noTest>
		
	^ aBoolean1
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> w: aBoolean1 w: aBoolean2 [
	<gtExample>
	<label: 'Dummy #w:w:, depends: #x: and #y:'>
	<dependsOn: #x:> 
	<dependsOn: #y:> 
	<noTest>
		
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> x: aBoolean1 [
	<gtExample>
	<label: 'Dummy #x:, depends: #y:'>
	<dependsOn: #y:> 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> y: aBoolean1 [
	<gtExample>
	<label: 'Dummy #y:, depends: #z:'>
	<dependsOn: #z:> 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> z: aBoolean1 [
	<gtExample>
	<label: 'Dummy #z:, depends: #t:t:'>
	<dependsOn: #t:t:>  " loop "
	<noTest>
	
	^ aBoolean1
]
