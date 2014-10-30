Extension { #name : #GLMActionListPresentation }

{ #category : #'*GT-Inspector-Examples' }
GLMActionListPresentation class >> examplesProvider [

	^ GTExampleProviderDelegator new
		targetProvider: GLMBasicExamples new;
		extractionStrategy: (GTExampleExtractionStrategy new
			addExampleConstructor: (GTCategoryExampleConstructor for: 'actionlist');
			yourself)
]
