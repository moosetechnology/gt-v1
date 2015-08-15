Class {
	#name : #GTInspectorExamplesTest,
	#superclass : #TestCase,
	#instVars : [
		'windows'
	],
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTInspectorExamplesTest >> checkAllPresentationsOf: exampleToTest [
	| browser window pragmas |
	pragmas := Pragma allNamed: #gtInspectorPresentationOrder: from: exampleToTest class to: Object.
	^ pragmas
		do: [ :eachPragma | 
			browser := GLMWrapper new.
			[browser
				show: [ :composite | 
					(eachPragma selector findTokens: $:) size = 1
						ifTrue: [ exampleToTest perform: eachPragma selector with: composite ].
					(eachPragma selector findTokens: $:) size = 2
						ifTrue: [ exampleToTest perform: eachPragma selector with: composite with: browser ] ].
			window := browser openOn: exampleToTest] 
				on: Error 
				do: [ self fail: (eachPragma method gtDisplayString, ' for ', exampleToTest gtDisplayString)  ].
			window ifNotNil: [ window delete ] ]
]

{ #category : #running }
GTInspectorExamplesTest >> setUp [ 
	windows := OrderedCollection new
]

{ #category : #running }
GTInspectorExamplesTest >> tearDown [ 
	windows do: [ :each | each delete ].
	windows := nil
]

{ #category : #tests }
GTInspectorExamplesTest >> testAllExamples [
	Object withAllSubclasses 
		do: [ :eachClass | eachClass gtExamples do: [ :exampleToTest | self checkAllPresentationsOf: exampleToTest ] ]
		displayingProgress: 'Testing GTInspector examples (#testAllExamples)'
]

{ #category : #tests }
GTInspectorExamplesTest >> testGlobals [
	{ Smalltalk . RBMessageNode . Trait . TClass . TBehavior . GTInspector . Object . Class . CompiledMethod } 
		do: [ :each | self checkAllPresentationsOf: each ]
		displayingProgress: 'Testing GTInspector globals (#testGlobals)'
]
