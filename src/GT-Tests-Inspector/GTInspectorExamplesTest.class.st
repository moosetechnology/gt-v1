Class {
	#name : #GTInspectorExamplesTest,
	#superclass : #TestCase,
	#instVars : [
		'pragmas'
	],
	#category : #'GT-Tests-Inspector'
}

{ #category : #running }
GTInspectorExamplesTest >> allExamplesClasses [
	" IMPORTANT NOTICE 
	1) We expicitly exclude examples from Roassal and Woden. Running all of those examples at once will severely slow down all tests and eventually cause segmentation faults - crash of image. This is not a fault/bug of GTExample - it happens also if the GTExample-wrapper is not used at all ! "
	^ ((Object withAllSubclasses 
		reject: [ :each | 
			(each name beginsWith: 'RT') 
				or: [ (each name beginsWith: 'RW')
					or: [ each name beginsWith: 'GTDummy' ] ] ]) 
		sort: [ :a :b | a name <= b name ])
]

{ #category : #running }
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
					self fail: (eachPragma method gtDisplayString, ' for ', exampleToTest gtDisplayString)  ].
		window ifNotNil: [ window delete ] ]
]

{ #category : #running }
GTInspectorExamplesTest >> pragmasFor: exampleToTest [
	^ pragmas 
		at: exampleToTest class 
		ifAbsentPut: [ Pragma allNamed: #gtInspectorPresentationOrder: from: exampleToTest class to: Object ]
]

{ #category : #running }
GTInspectorExamplesTest >> setUp [
	super setUp.
	
	GTExampleOrganizer instance stop.
	pragmas := IdentityDictionary new.
	GTExampleOrganizer instance resetResults
]

{ #category : #running }
GTInspectorExamplesTest >> tearDown [
	super tearDown.
	
	GTExampleOrganizer instance resetResults.
	pragmas := nil.
	GTExampleOrganizer instance start.
]

{ #category : #tests }
GTInspectorExamplesTest >> testAllExamples [
	self allExamplesClasses
		do: [ :eachClass | 
			eachClass gtExamples do: [ :exampleToTest | 
				self checkAllPresentationsOf: exampleToTest ] ]
]

{ #category : #tests }
GTInspectorExamplesTest >> testGlobals [
	{ Smalltalk . RBMessageNode . Trait . TClass . TBehavior . GTInspector . Object . Class . CompiledMethod } 
		do: [ :each | self checkAllPresentationsOf: each ]
]
