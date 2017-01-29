Class {
	#name : #GTDummyExamplesWithAfter,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> a: b [
	<gtExample>
	<dependsOn: #b:>
	<after: #afterA>
	" START -> C B A -> afterA -> afterB -> afterC -> END "
	
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #c2).
	self assert: (self gtExampleContext includesKey: #b).
	self assert: (self gtExampleContext includesKey: #b2).
	
	self gtExampleContext at: #a put: #a.
	self gtExampleContext at: #a2 put: #a2.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> afterA [
	self assert: (self gtExampleContext includesKey: #a).
	self assert: (self gtExampleContext includesKey: #b).
	self assert: (self gtExampleContext includesKey: #b2).
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #c2).
	
	self gtExampleContext removeKey: #a.
	
	self assert: (self gtExampleContext includesKey: #a) not.
	self assert: (self gtExampleContext includesKey: #b).
	self assert: (self gtExampleContext includesKey: #b2).
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #c2).
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> afterB [
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #c2).
	self assert: (self gtExampleContext includesKey: #b).
	self assert: (self gtExampleContext includesKey: #b2).
	
	self gtExampleContext removeKey: #b.
	
	self assert: (self gtExampleContext includesKey: #b) not.
	self assert: (self gtExampleContext includesKey: #b2).
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #c2).
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> afterC [	
	self assert: (self gtExampleContext includesKey: #c).
	
	self gtExampleContext removeKey: #c.
	
	self assert: (self gtExampleContext includesKey: #c) not.
	self assert: (self gtExampleContext includesKey: #c2).
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfter class >> b: c [
	<gtExample>
	<dependsOn: #c>
	<after: #afterB>
	" START -> C B -> afterB -> afterC -> END "
	
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #c2).
	
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
