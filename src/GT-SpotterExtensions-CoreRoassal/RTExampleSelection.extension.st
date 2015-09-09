Extension { #name : #RTExampleSelection }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTExampleSelection >> gtSpotterPreviewIconIn: aComposite [
	<spotterPreview: 10>
	(self provider class canPerform: (self selector, 'Icon') asSymbol)
		ifTrue: [ 
			aComposite addBrickBack: (self iconForm asAlphaImageMorph
				layout: #center;
				scale: 2.0) asBrick ]

	
]

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTExampleSelection >> matchesQuery: aSetOfNames [
	| sourceCode |
	
	sourceCode := self method sourceCode asLowercase.
	^ aSetOfNames allSatisfy: [ :each | sourceCode includesSubstring: each ]

]

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTExampleSelection >> spotterPreviewExampleIn: aComposite [
	self deprecated: 'Please use #gtSpotterPreviewIconIn: instead'>
	self gtSpotterPreviewIconIn: aComposite
	
]
