Class {
	#name : #GTInspectorExamplesTest,
	#superclass : #TestCase,
	#instVars : [
		'windows'
	],
	#category : #'GT-Tests-Inspector'
}

{ #category : #running }
GTInspectorExamplesTest >> setUp [ 
	windows := OrderedCollection new
]

{ #category : #running }
GTInspectorExamplesTest >> tearDown [ 
	windows do: [ :each | each delete ]
]

{ #category : #tests }
GTInspectorExamplesTest >> testEachPresentation [

	| pragmas window |

	Object withAllSubclassesDo: [ :eachClass |
		(GTExamplesBrowser new examplesFor: eachClass) do: [ :exampleToTest |
			pragmas := Pragma 
						allNamed: #gtInspectorPresentationOrder: 
						from: exampleToTest class 
						to: Object 
						sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
			pragmas do: [ :eachPragma | 
				window := GLMWrapper new 
					show: [:composite | 
						exampleToTest perform: eachPragma selector with: composite];
					openOn: exampleToTest.
				windows add: window ] ] ]
]
