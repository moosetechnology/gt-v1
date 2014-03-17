Class {
	#name : #GTInspectorSmokeTest,
	#superclass : #TestCase,
	#instVars : [
		'windows'
	],
	#category : #'GT-Tests-Inspector'
}

{ #category : #testing }
GTInspectorSmokeTest class >> isAbstract [
	^ self name = #GTInspectorSmokeTest
]

{ #category : #tests }
GTInspectorSmokeTest >> objectToTest. [

	^ self subclassResponsability
]

{ #category : #running }
GTInspectorSmokeTest >> setUp [ 
	windows := OrderedCollection new
]

{ #category : #running }
GTInspectorSmokeTest >> tearDown [ 
	windows do: [ :each | each delete ]
]

{ #category : #tests }
GTInspectorSmokeTest >> testEachPresentation [

	| pragmas objectToTest browser window |

	objectToTest := self objectToTest.
	pragmas := Pragma 
				allNamed: #gtInspectorPresentationOrder: 
				from: objectToTest class 
				to: Object 
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas do: [ :eachPragma | 
		browser := GLMWrapper new.
		browser show: [:composite | 
			(eachPragma selector findTokens: $:) size = 1 
			ifTrue: [ objectToTest perform: eachPragma selector with: composite ]. 
		(eachPragma selector findTokens: $:) size = 2
			ifTrue: [ objectToTest perform: eachPragma selector with: composite with: browser ] ].
		window := browser openOn: objectToTest.
		windows add: window ]
]
