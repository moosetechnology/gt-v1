Class {
	#name : #GTDummyExamplesWithAfter2WithExceptions,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Set-3'
}

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2WithExceptions class >> afterB: a b: b b: c [
	self assert: a notNil.
	self assert: a class = GTExample.
	
	self assert: b notNil.
	self assert: b == Smalltalk.
	
	self assert: c notNil.
	self assert: c = 2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2WithExceptions class >> afterC: a c: b c: c [
	self assert: a notNil.
	self assert: a class = GTExample.
	
	self assert: b notNil.
	self assert: b == Smalltalk.
	
	self assert: c notNil.
	self assert: c = 'abcd'.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2WithExceptions class >> afterD: a d: b d: c [
	self assert: a notNil.
	self assert: a class = Object.
	
	self assert: b notNil.
	self assert: b == Smalltalk.
	
	self assert: c notNil.
	self assert: c = 'abc'.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2WithExceptions class >> b2: argB [
	<gtExample>
	<depends: #c:>
	<after: #afterB:b: arguments: #( varA varB argB )> " mistake "
	<raises: #KeyNotFound> 
	" START -> D -> afterD:d:d: -> C -> afterC:c:c: -> B -> afterB:b: [ERROR] -> END "
	
	| varA varB |
	
	self assert: argB = 2.
	
	varA := GTExample new.
	varB := Smalltalk.
	
	^ 3
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2WithExceptions class >> b3: argB [
	<gtExample>
	<depends: #c:>
	<after: #afterB:b:b: arguments: #( varA varB varC )> " mistake "
	<raises: #AssertionFailure> " todo: THIS IS WRONG ! better: verify the static setup first "
	" START -> D -> afterD:d:d: -> C -> afterC:c:c: -> B -> afterB:b:b: -> END "
	
	| varA varB |
	
	self assert: argB = 2.
	
	varA := GTExample new.
	varB := Smalltalk.
	
	^ 3
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2WithExceptions class >> c: argC [
	<gtExample>
	<depends: #d>
	<after: #afterC:c:c: arguments: #( varA varB varC )>
	" START -> D -> afterD:d:d: -> C -> afterC:c:c: -> END "
	
	| varA varB varC |
	
	self assert: argC = 1.
	
	varA := GTExample new.
	varB := Smalltalk.
	varC := 'abcd'.	
			
	^ 2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2WithExceptions class >> d [
	<gtExample>
	<after: #afterD:d:d: arguments: #( varA varB varC )>
	" START -> D -> afterD:d:d: -> END "
	
	| varA varB varC |
	
	varA := Object new.
	varB := Smalltalk.
	varC := 'abc'.	
			
	^ 1
]
