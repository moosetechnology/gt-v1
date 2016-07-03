Extension { #name : #TClassDescription }

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamples [
	^ self gtExamplesFactory gtExamplesContained
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamplesDo: aBlock [
	self gtExamplesFactory gtExamplesContainedDo: aBlock
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamplesFactory [
	^ GTExampleFactory new
		source: self;
		yourself
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamplesFinder [
	^ GTExampleFinder new
		source: self gtExamplesSource;
		provider: self gtExamplesProvider;
		subjects: self gtExamplesSubjects;
		yourself
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamplesProvider [
	" by default let a class be the provider for examples "
	^ self
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamplesSource [
	" by default let a class be the source for examples "
	^ self
]

{ #category : #'*GT-Examples-Core' }
TClassDescription >> gtExamplesSubjects [
	^ {  }
]
