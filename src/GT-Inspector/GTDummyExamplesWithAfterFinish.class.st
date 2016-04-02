Class {
	#name : #GTDummyExamplesWithAfterFinish,
	#superclass : #Object,
	#category : #'GT-Inspector-Examples-Dummies-1'
}

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> a: b [
	<gtExample>
	<depends: #b:>
	<after: #afterA>
	<afterFinish: #afterAfinish>
	
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #b).
	self assert: (self gtExampleContext includesKey: #a) not
	
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> afterA [
	self gtExampleContext at: #a put: #a.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> afterAfinish [
	self assert: (self gtExampleContext includesKey: #a).
	self gtExampleContext removeKey: #a.
	self assert: (self gtExampleContext includesKey: #a) not.
	
	self assert: (self gtExampleContext includesKey: #b).
	self gtExampleContext removeKey: #b.
	self assert: (self gtExampleContext includesKey: #b) not.
	
	self assert: (self gtExampleContext includesKey: #c).
	self gtExampleContext removeKey: #c.
	self assert: (self gtExampleContext includesKey: #c) not.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> afterB [
	self gtExampleContext at: #b put: #b.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> afterBfinish [
	self assert: (self gtExampleContext includesKey: #b).
	self gtExampleContext removeKey: #b.
	self assert: (self gtExampleContext includesKey: #b) not.
	
	self assert: (self gtExampleContext includesKey: #c).
	self gtExampleContext removeKey: #c.
	self assert: (self gtExampleContext includesKey: #c) not.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> afterC [
	self gtExampleContext at: #c put: #c.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> afterCfinish [
	self assert: (self gtExampleContext includesKey: #c).
	self gtExampleContext removeKey: #c.
	self assert: (self gtExampleContext includesKey: #c) not.
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> b: c [
	<gtExample>
	<depends: #c>
	<after: #afterB>
	<afterFinish: #afterBfinish>
	
	self assert: (self gtExampleContext includesKey: #c).
	self assert: (self gtExampleContext includesKey: #b) not
]

{ #category : #'as yet unclassified' }
GTDummyExamplesWithAfterFinish class >> c [
	<gtExample>
	<after: #afterC>
	<afterFinish: #afterCfinish>
	
	self assert: (self gtExampleContext includesKey: #c) not
]
