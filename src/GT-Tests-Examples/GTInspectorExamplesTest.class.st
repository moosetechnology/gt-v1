Class {
	#name : #GTInspectorExamplesTest,
	#superclass : #TestCase,
	#instVars : [
		'pragmas'
	],
	#category : #'GT-Tests-Examples'
}

{ #category : #running }
GTInspectorExamplesTest >> allExamples [
	" IMPORTANT NOTICE 
	1) We expicitly exclude examples from Roassal and Woden. Running all of those examples at once will severely slow down all tests and eventually cause segmentation faults - crash of image. This is not a fault/bug of GTExample - it happens also if the GTExample-wrapper is not used at all ! "
	^ Smalltalk gtExamplesContained reject: [ :each | 
		each ignoreTest
			or: [ each ignoreTestReport
				or: [ { 'RT'. 'RW'. 'GTDummy' } anySatisfy: [ :prefix | 
									each methodClass name beginsWith: prefix ] ] ] ]
]

{ #category : #running }
GTInspectorExamplesTest >> checkAllPresentationsOf: exampleToTest [
	| browser window |
	exampleToTest class name = #ProtoObject ifTrue: [ ^ self ]. " no longer implemented "
	(Pragma
		allNamed: #gtInspectorPresentationOrder:
		from: exampleToTest class
		to: ProtoObject)
		do: [ :eachPragma | 
			browser := GLMWrapper new.
			[ browser
				show: [ :composite | 
					(eachPragma methodSelector findTokens: $:) size = 1
						ifTrue: [ exampleToTest perform: eachPragma methodSelector with: composite ].
					(eachPragma methodSelector findTokens: $:) size = 2
						ifTrue: [ exampleToTest
								perform: eachPragma methodSelector
								with: composite
								with: browser ] ].
			window := browser openOn: exampleToTest ]
				on: Error
				do: [ window ifNotNil: [ window delete ].
					self
						fail:
							eachPragma method gtDisplayString , ' for '
								, exampleToTest gtDisplayString ].
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
	
	pragmas := IdentityDictionary new.
	GTExampleOrganizer reset; stop
]

{ #category : #running }
GTInspectorExamplesTest >> tearDown [
	super tearDown.
	
	pragmas := nil.
	GTExampleOrganizer reset; start
]

{ #category : #tests }
GTInspectorExamplesTest >> testAllExamples [
	| examples |
	(examples := self allExamples)
		do: [ :exampleToTest | self checkAllPresentationsOf: exampleToTest returnValue ]
		displayingProgress: 'Running ', examples size asString, ' Examples for Inspector-Presentations'
]

{ #category : #tests }
GTInspectorExamplesTest >> testGlobals [
	| globals |
	(globals := { Smalltalk . RBMessageNode . Trait . TClass . TBehavior . GTInspector . Object . Class . CompiledMethod })
		do: [ :each | self checkAllPresentationsOf: each ]
		displayingProgress: 'Running ', globals size asString, ' globals for Inspector-Presentations'
]
