Extension { #name : #TraitDescription }

{ #category : #'*GT-Examples-Core' }
TraitDescription >> asGTExampleSubject [
	^ self class gtExamplesFactoryClass classSubjectFrom: self
]

{ #category : #'*GT-Examples-Core' }
TraitDescription >> gtExamples [
	^ self gtExamplesFactory gtExamplesContained
]

{ #category : #'*GT-Examples-Core' }
TraitDescription >> gtExamplesFactory [
	^ self class gtExamplesFactoryClass new
		source: self;
		yourself
]

{ #category : #'*GT-Examples-Core' }
TraitDescription >> gtExamplesSubjects [
	^ { self }
]
