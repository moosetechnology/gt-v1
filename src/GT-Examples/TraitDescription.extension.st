Extension { #name : #TraitDescription }

{ #category : #'*GT-Examples-Core' }
TraitDescription >> asGTExampleSubject [
	^ GTExampleClassSubject new 
		theClassName: self name;
		theClass: self;
		meta: self isMeta;
		yourself
]

{ #category : #'*GT-Examples-Core' }
TraitDescription >> gtExamples [
	^ self gtExamplesFactory gtExamplesContained
]

{ #category : #'*GT-Examples-Core' }
TraitDescription >> gtExamplesFactory [
	^ GTExampleFactory new
		source: self;
		yourself
]

{ #category : #'*GT-Examples-Core' }
TraitDescription >> gtExamplesSubjects [
	^ { self }
]
