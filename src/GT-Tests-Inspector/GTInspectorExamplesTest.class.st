Class {
	#name : #GTInspectorExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTInspectorExamplesTest >> checkAllPresentationsOf: exampleToTest [
	| browser window |
	(Pragma allNamed: #gtInspectorPresentationOrder: from: exampleToTest class to: Object) do: [ :eachPragma | 
		browser := GLMWrapper new.
		[	browser
				show: [ :composite | 
					(eachPragma selector findTokens: $:) size = 1
						ifTrue: [ exampleToTest perform: eachPragma selector with: composite ].
					(eachPragma selector findTokens: $:) size = 2
						ifTrue: [ exampleToTest perform: eachPragma selector with: composite with: browser ] ].
			window := browser openOn: exampleToTest ] 
				on: Error 
				do: [
					window ifNotNil: [ window delete ].
					(eachPragma method gtDisplayString, ' for ', exampleToTest gtDisplayString) logCr.
					"self fail: (eachPragma method gtDisplayString, ' for ', exampleToTest gtDisplayString)"  ].
		window ifNotNil: [ window delete ] ]
]

{ #category : #running }
GTInspectorExamplesTest >> tearDown [
	super tearDown.
	 
	(Smalltalk classNamed: #GTExampleOrganizer) 
		ifNotNil: [ :class | class instance resetResults ]
]

{ #category : #tests }
GTInspectorExamplesTest >> testAllExamples [
	Object withAllSubclasses
		do: [ :eachClass | 
			eachClass gtExamples do: [ :exampleToTest | 
				self checkAllPresentationsOf: exampleToTest.
				exampleToTest detachResultFromSystem ] ]
		displayingProgress: 'Testing GTInspector examples (#testAllExamples)'
]

{ #category : #tests }
GTInspectorExamplesTest >> testGlobals [
	{ Smalltalk . RBMessageNode . Trait . TClass . TBehavior . GTInspector . Object . Class . CompiledMethod } 
		do: [ :each | self checkAllPresentationsOf: each ]
		displayingProgress: 'Testing GTInspector globals (#testGlobals)'
]
