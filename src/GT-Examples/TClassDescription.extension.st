Extension { #name : #TClassDescription }

{ #category : #'*GT-Examples-Core' }
TClassDescription >> asGTExampleSubject [
	^ GTExampleClassSubject new 
		subjectClass: self;
		yourself
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamples [
	^ self gtExamplesFactory gtExamplesContained
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamplesFactory [
	^ GTExampleFactory new
		source: self;
		yourself
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamplesSubjects [
	^ {  }
]
