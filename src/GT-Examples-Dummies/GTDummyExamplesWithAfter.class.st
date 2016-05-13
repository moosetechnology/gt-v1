Class {
	#name : #GTDummyExamplesWithAfter,
	#superclass : #Object,
	#category : #'GT-Examples-Dummies-Set-3'
}

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> a: b [
	<gtExample>
	<depends: #b:>
	<after: #afterA>
	" START -> C B A -> afterC -> afterB -> afterA -> END "
	
	self assert: (self gtExampleContext includesKey: #c) not.
	self assert: (self gtExampleContext includesKey: #b) not.
	
	self assert: (self gtExampleContext includesKey: #c2).
	self assert: (self gtExampleContext includesKey: #b2).
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> afterA [
	self gtExampleContext removeKey: #b2.
	self gtExampleContext removeKey: #c2.
	
	self assert: self gtExampleContext isEmpty
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> afterB [
	self gtExampleContext removeKey: #b.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> afterC [	
	self gtExampleContext removeKey: #c.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> b: c [
	<gtExample>
	<depends: #c>
	<after: #afterB>
	" START -> C B -> afterC -> afterB -> END "
	
	self assert: (self gtExampleContext includesKey: #c) not.
	
	self gtExampleContext at: #b put: #b.
	self gtExampleContext at: #b2 put: #b2.
	
	self assert: ((self gtExampleContext at: #b) = #b).
	self assert: ((self gtExampleContext at: #b2) = #b2).
	
	^ #b2
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> c [
	<gtExample>
	<after: #afterC>
	" START -> C -> afterC -> END "
	
	self gtExampleContext at: #c put: #c.
	self gtExampleContext at: #c2 put: #c2.
	
	self assert: ((self gtExampleContext at: #c) = #c).
	self assert: ((self gtExampleContext at: #c2) = #c2).
	
	^ #c2
]
