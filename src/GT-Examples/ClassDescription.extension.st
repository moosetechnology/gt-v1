Extension { #name : #ClassDescription }

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamplesFinder [
	^ GTExampleFinder new
		source: self gtExamplesSource;
		provider: self gtExamplesProvider;
		subjects: self gtExamplesSubjects;
		yourself
]
