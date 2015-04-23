Extension { #name : #RTExampleSelection }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTExampleSelection >> matchesQuery: aSetOfNames [
	| sourceCode |
	
	sourceCode := (self provider class >> self selector) sourceCode asLowercase.
	^ aSetOfNames allSatisfy: [ :each | sourceCode includesSubstring: each ]

]

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTExampleSelection >> spotterPreviewExampleIn: aComposite [
	<spotterPreview: 10>
	(self provider class canPerform: (self selector, 'Icon') asSymbol)
		ifTrue: [ 
			aComposite addBrickBack: (self iconForm asAlphaImageMorph
				layout: #center;
				scale: 2.0) asBrick ]

	
]
