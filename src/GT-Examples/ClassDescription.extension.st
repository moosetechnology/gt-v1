Extension { #name : #ClassDescription }

{ #category : #'*GT-Examples-Core' }
ClassDescription >> asGTExampleSubject [
	^ self gtExamplesFactoryClass classSubjectFrom: self
]

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamples [
	^ self gtExamplesFactory gtExamplesContained
]

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamplesFactory [
	^ self gtExamplesFactoryClass new
		source: self;
		yourself
]

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamplesFactoryClass [
	^ GTExampleFactory
]

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamplesSubjects [
	^ { self }
]
