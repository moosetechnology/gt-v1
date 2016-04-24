Class {
	#name : #GTDummyExamplesRecursive,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Set-1'
}

{ #category : #'examples 1' }
GTDummyExamplesRecursive class >> a: aBoolean [
	<gtExample>
	<label: 'Dummy #a:, depends: #a:'>
	<depends: #a:> " loop "
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 1' }
GTDummyExamplesRecursive class >> b: aBoolean [
	<gtExample>
	<label: 'Dummy #b:, depends: #a:'>
	<depends: #a:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 1' }
GTDummyExamplesRecursive class >> c: aBoolean [
	<gtExample>
	<label: 'Dummy #c:, depends: #b:'>
	<depends: #b:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 2' }
GTDummyExamplesRecursive class >> d: aBoolean [
	<gtExample>
	<label: 'Dummy #d:, depends: #f:'>
	<depends: #f:> " loop "
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 2' }
GTDummyExamplesRecursive class >> e: aBoolean [
	<gtExample>
	<label: 'Dummy #e:, depends: #d:'>
	<depends: #d:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 2' }
GTDummyExamplesRecursive class >> f: aBoolean [
	<gtExample>
	<label: 'Dummy #f:, depends: #e:'>
	<depends: #e:>
	<noTest>
	
	^ aBoolean
]

{ #category : #'examples 3' }
GTDummyExamplesRecursive class >> g: aBoolean1 g: aBoolean2 [
	<gtExample>
	<label: 'Dummy #g:g:, depends: #i:i: and #h'>
	<depends: #i:i:>
	<depends: #h>
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
	<depends: #j:>
	<depends: #h>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 3' }
GTDummyExamplesRecursive class >> j: aBoolean1 [
	<gtExample>
	<label: 'Dummy #j:, depends: #g:'>
	<depends: #g:g:> " loop "
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 4' }
GTDummyExamplesRecursive class >> k: aBoolean1 k: aBoolean2 [
	<gtExample>
	<label: 'Dummy #k:k:, depends: #m:m: and #l:l:'>
	<depends: #l:l:>
	<depends: #m:m:>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 4' }
GTDummyExamplesRecursive class >> l: aBoolean1 l: aBoolean2 [
	<gtExample>
	<label: 'Dummy #l:l:, depends: #k:k: and #n:'>
	<depends: #k:k:> " loop "
	<depends: #n:>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 4' }
GTDummyExamplesRecursive class >> m: aBoolean1 m: aBoolean2 [
	<gtExample>
	<label: 'Dummy #m:m:, depends: #l:l: and #n:'>
	<depends: #l:l:>
	<depends: #n:>
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 4' }
GTDummyExamplesRecursive class >> n: aBoolean1 [
	<gtExample>
	<label: 'Dummy #n:, depends: #k:k:'>
	<depends: #k:k:> " loop "
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 5' }
GTDummyExamplesRecursive class >> o: aBoolean1 [
	<gtExample>
	<label: 'Dummy #o:, depends: #p:'>
	<depends: #p:> 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 5' }
GTDummyExamplesRecursive class >> p: aBoolean1 [
	<gtExample>
	<label: 'Dummy #p:, depends: #o:'>
	<depends: #o:> " loop " 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 6' }
GTDummyExamplesRecursive class >> q: aBoolean1 q: aBoolean2 [
	<gtExample>
	<label: 'Dummy #q:q:, depends: #r: and #r:'>
	<depends: #r:> 
	<depends: #r:> 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 6' }
GTDummyExamplesRecursive class >> r: aBoolean1 [
	<gtExample>
	<label: 'Dummy #r:, depends: #s:'>
	<depends: #s:> 
	<noTest>
		
	^ aBoolean1
]

{ #category : #'examples 6' }
GTDummyExamplesRecursive class >> s: aBoolean1 [
	<gtExample>
	<label: 'Dummy #s:, depends: #q:q:'>
	<depends: #q:q:> " loop " 
	<noTest>
		
	^ aBoolean1
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> t: aBoolean1 t: aBoolean2 [
	<gtExample>
	<label: 'Dummy #t:t:, depends: #u:u: and #v:'>
	<depends: #u:u:> 
	<depends: #v:> 
	<noTest>
		
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> u: aBoolean1 u: aBoolean2 [
	<gtExample>
	<label: 'Dummy #u:u:, depends: #v: and #w:w:'>
	<depends: #w:w:> 
	<depends: #v:> 
	<noTest>
	
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> v: aBoolean1 [
	<gtExample>
	<label: 'Dummy #v:, depends: #x:'>
	<depends: #x:> 
	<noTest>
		
	^ aBoolean1
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> w: aBoolean1 w: aBoolean2 [
	<gtExample>
	<label: 'Dummy #w:w:, depends: #x: and #y:'>
	<depends: #x:> 
	<depends: #y:> 
	<noTest>
		
	^ aBoolean1 & aBoolean2
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> x: aBoolean1 [
	<gtExample>
	<label: 'Dummy #x:, depends: #y:'>
	<depends: #y:> 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> y: aBoolean1 [
	<gtExample>
	<label: 'Dummy #y:, depends: #z:'>
	<depends: #z:> 
	<noTest>
	
	^ aBoolean1
]

{ #category : #'examples 7' }
GTDummyExamplesRecursive class >> z: aBoolean1 [
	<gtExample>
	<label: 'Dummy #z:, depends: #t:t:'>
	<depends: #t:t:>  " loop "
	<noTest>
	
	^ aBoolean1
]
