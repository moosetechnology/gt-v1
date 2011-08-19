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
				allNamed: #objectFinderPresentationOrder: 
				from: objectToTest class 
				to: Object 
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas do: [ :eachPragma | 
		browser := GLMTabulator new.
		browser column: #one.
		browser transmit to: #one; andShow: [:composite | 
			objectToTest perform: eachPragma selector with: composite].
		window := browser openOn: objectToTest.
		windows add: window ]
]
