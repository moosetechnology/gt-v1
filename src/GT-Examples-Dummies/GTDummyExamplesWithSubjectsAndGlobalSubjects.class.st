Class {
	#name : #GTDummyExamplesWithSubjectsAndGlobalSubjects,
	#superclass : #GTAbstractDummyExamples,
	#category : #'GT-Examples-Dummies-Data'
}

{ #category : #config }
GTDummyExamplesWithSubjectsAndGlobalSubjects >> gtExamplesSubjects [
	^ { Object. Array. GTExample }
]

{ #category : #examples }
GTDummyExamplesWithSubjectsAndGlobalSubjects >> multipleSubjects1 [
	<gtExample>
	<subjectClass: 'GTExample' selector: #methodClass>
	<subjectClass: #GTExample selector: #selector>
	
	self assert: self gtExampleContext example subjects size = 5.
	self assert: (self gtExampleContext example subjects select: [ :each | each exists ]) size = 5.
	
	^ 0
]

{ #category : #examples }
GTDummyExamplesWithSubjectsAndGlobalSubjects >> multipleSubjects2 [
	<gtExample>
	<subject: 'GTExample'> " overlap "
	<subjectClass: 'Object'> " overlap "
	<subjectClass: #Array> " overlap "
	<subjectClass: 'GTExample' selector: #methodClass>
	<subjectClass: #GTExample selector: #selector>
	
	self assert: self gtExampleContext example subjects size = 5.
	self assert: (self gtExampleContext example subjects select: [ :each | each exists ]) size = 5.
	
	^ 0
]
