Extension { #name : #RTExampleSelection }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTExampleSelection >> matchesQuery: aSetOfNames [
	| sourceCode |
	
	sourceCode := (self exampleObject class >> self selector) sourceCode asLowercase.
	^ aSetOfNames allSatisfy: [ :each | sourceCode includesSubstring: each ]

]
