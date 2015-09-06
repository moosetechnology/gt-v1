Extension { #name : #RTObject }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTObject classSide >> gtExamplesFinder [
	^ RTExampleFinder new
		source: self gtExamplesSource;
		provider: self gtExamplesProvider;
		subjects: self gtExamplesSubjects;
		yourself
]
