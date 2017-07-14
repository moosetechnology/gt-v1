Extension { #name : #ClassDescription }

{ #category : #'*GT-Examples-Core' }
ClassDescription >> asGTExampleSubject [
	^ GTExampleClassSubject new 
		theClassName: self name;
		theClass: self;
		meta: self isMeta;
		yourself
]

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamples [
	^ self gtExamplesFactory gtExamplesContained
]

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamplesFactory [
	^ GTExampleFactory new
		source: self;
		yourself
]

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamplesSubjects [
	^ { self }
]
