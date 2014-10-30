Extension { #name : #GLMTablePresentation }

{ #category : #'*GT-Inspector-Examples' }
GLMTablePresentation class >> examplesProvider [

	^ GTExampleProviderDelegator new
		targetProvider: GLMBasicExamples new;
		extractionStrategy: (GTExampleExtractionStrategy new
			addExampleConstructor: (GTCategoryExampleConstructor for: 'table');
			yourself)
]
