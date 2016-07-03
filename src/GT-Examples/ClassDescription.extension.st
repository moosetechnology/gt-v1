Extension { #name : #ClassDescription }

{ #category : #'*GT-Examples-Core' }
ClassDescription >> gtExamplesFinder [
	^ GTExampleFinderOLD new
		source: self gtExamplesSource;
		provider: self gtExamplesProvider;
		subjects: self gtExamplesSubjects;
		yourself
]
