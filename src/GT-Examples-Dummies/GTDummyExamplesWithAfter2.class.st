Class {
	#name : #GTDummyExamplesWithAfter2,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Set-3'
}

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> a: b [
	<gtExample>
	<depends: #b:>
	<after: #afterA:>
	" START -> C B A -> afterC -> afterB -> afterA -> END "
	
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #b).
	
	self gtExampleContext at: #a put: #a.
	self assert: (self gtExampleContext includesKey: #a).
	
	^ #a2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> afterA: arg [
	self assert: arg = #a2.
	
	self assert: (self gtExampleContext includesKey: #c) not.
	self assert: (self gtExampleContext includesKey: #b) not.
	self gtExampleContext removeKey: #a.
	self assert: (self gtExampleContext includesKey: #a) not.
	
	self assert: self gtExampleContext isEmpty
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> afterB: arg [
	self assert: arg = #b2.
	
	self assert: (self gtExampleContext includesKey: #c) not.
	self gtExampleContext removeKey: #b.
	self assert: (self gtExampleContext includesKey: #b) not.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> afterC: arg [
	self assert: arg = #c2.
	
	self gtExampleContext removeKey: #c.
	self assert: (self gtExampleContext includesKey: #c) not.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> b: c [
	<gtExample>
	<depends: #c>
	<after: #afterB:>
	" START -> C B -> afterC -> afterB -> END "
	
	self assert: (self gtExampleContext includesKey: #c).
	
	self gtExampleContext at: #b put: #b.
	self assert: ((self gtExampleContext at: #b) = #b).
	
	^ #b2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter2 class >> c [
	<gtExample>
	<after: #afterC:>
	" START -> C -> afterC -> END "
	
	self gtExampleContext at: #c put: #c.
	self assert: ((self gtExampleContext at: #c) = #c).
	
	^ #c2
]
