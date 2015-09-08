Extension { #name : #RTExampleSelection }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTExampleSelection >> gtInspectorRoassalViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Canvas';
		initializeView: [ self returnValue ]
		
]

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTExampleSelection >> gtInspectorViewIn: composite [
	<todo: 'deprecated: #gtInspectorViewIn:'>
	^ self gtInspectorRoassalViewIn: composite
]

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
	<todo: 'deprecated: #spotterPreviewExampleIn:'>
	self gtSpotterPreviewIconIn: aComposite
	
]
