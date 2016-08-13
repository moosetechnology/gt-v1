Class {
	#name : #GTDummyExamplesWithGlobalSubjects,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #examples }
GTDummyExamplesWithGlobalSubjects class >> classSideSubjects1 [
	<gtExample>
	
	self assert: self gtExampleContext example subjects first class = GTExampleClassSubject.
	self assert: self gtExampleContext example subjects first theClassName = 'GTExample'.
	self assert: self gtExampleContext example subjects first theClass = GTExample.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithGlobalSubjects class >> classSideSubjects2 [
	<gtExample>
	
	self assert: self gtExampleContext example subjects first class = GTExampleClassSubject.
	self assert: self gtExampleContext example subjects first theClassName = 'GTExample'.
	self assert: self gtExampleContext example subjects first theClass = GTExample.
	self assert: self gtExampleContext example subjects first exists.
	
	^ 0
]

{ #category : #config }
GTDummyExamplesWithGlobalSubjects class >> gtExamplesSubjects [
	^ { GTExample }
]

{ #category : #config }
GTDummyExamplesWithGlobalSubjects >> gtExamplesSubjects [
	^ { Object. Array. GTExample >> #run. GTExample }
]

{ #category : #examples }
GTDummyExamplesWithGlobalSubjects >> multipleSubjects1 [
	<gtExample>
	
	self assert: self gtExampleContext example subjects size = 4.
	self assert: (self gtExampleContext example subjects allSatisfy: [ :each | each exists ]).
	self gtExamplesSubjects do: [ :each |
		self assert: (self gtExampleContext example hasSubject: each asGTExampleSubject) ].
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithGlobalSubjects >> multipleSubjects2 [
	<gtExample>
	
	self assert: self gtExampleContext example subjects size = 4.
	self assert: (self gtExampleContext example subjects allSatisfy: [ :each | each exists ]).
	self gtExamplesSubjects do: [ :each |
		self assert: (self gtExampleContext example hasSubject: each asGTExampleSubject) ].
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithGlobalSubjects >> multipleSubjects3 [
	<gtExample>
	
	self assert: self gtExampleContext example subjects size = 4.
	self assert: (self gtExampleContext example subjects allSatisfy: [ :each | each exists ]).
	self gtExamplesSubjects do: [ :each |
		self assert: (self gtExampleContext example hasSubject: each asGTExampleSubject) ].
	
	^ 0
]
