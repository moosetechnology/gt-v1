Extension { #name : #TClassDescription }

{ #category : #'*GT-Inspector-Examples-Core' }
TClassDescription >> gtExamples [
	^ self gtExamplesFinder gtExamplesContained
]

{ #category : #'*GT-Inspector-Examples-Core' }
TClassDescription >> gtExamplesFinder [
	^ GTExampleFinder new
		source: self gtExamplesSource;
		provider: self gtExamplesProvider;
		subjects: self gtExamplesSubjects;
		yourself
]

{ #category : #'*GT-Inspector-Examples-Core' }
TClassDescription >> gtExamplesProvider [
	" by default let a class be the provider for examples "
	^ self
]

{ #category : #'*GT-Inspector-Examples-Core' }
TClassDescription >> gtExamplesSource [
	" by default let a class be the source for examples "
	^ self
]

{ #category : #'*GT-Inspector-Examples-Core' }
TClassDescription >> gtExamplesSubjects [
	" by default let a class be the (implicit) subject for examples "
	^ nil
]
