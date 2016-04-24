Class {
	#name : #GTDummyExamplesWithAfter2,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Set-3'
}

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> afterB: a b: b b: c [
	self assert: a notNil.
	self assert: a class = GTExample.
	
	self assert: b notNil.
	self assert: b == Smalltalk.
	
	self assert: c notNil.
	self assert: c = 2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> afterC: a c: b c: c [
	self assert: a notNil.
	self assert: a class = GTExample.
	
	self assert: b notNil.
	self assert: b == Smalltalk.
	
	self assert: c notNil.
	self assert: c = 'abcd'.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> afterD: a d: b d: c [
	self assert: a notNil.
	self assert: a class = Object.
	
	self assert: b notNil.
	self assert: b == Smalltalk.
	
	self assert: c notNil.
	self assert: c = 'abc'.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> b: argB [
	<gtExample>
	<depends: #c:>
	<after: #afterB:b:b: arguments: #( varA varB argB )>
	| varA varB |
	
	self assert: argB = 2.
	
	varA := GTExample new.
	varB := Smalltalk.
	
	^ 3
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> c: argC [
	<gtExample>
	<depends: #d>
	<after: #afterC:c:c: arguments: #( varA varB varC )>
	| varA varB varC |
	
	self assert: argC = 1.
	
	varA := GTExample new.
	varB := Smalltalk.
	varC := 'abcd'.	
			
	^ 2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> d [
	<gtExample>
	<after: #afterD:d:d: arguments: #( varA varB varC )>
	| varA varB varC |
	
	varA := Object new.
	varB := Smalltalk.
	varC := 'abc'.	
			
	^ 1
]
