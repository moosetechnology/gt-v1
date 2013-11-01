Class {
	#name : #GTInspectorMorphTest,
	#superclass : #GTInspectorSmokeTest,
	#instVars : [
		'morphWindow'
	],
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTInspectorMorphTest >> objectToTest [ 
	"we spawn the morph to make sure there are no errors when the morph is actually drawn"
	^ morphWindow := BorderedMorph new openInWindow 
]

{ #category : #running }
GTInspectorMorphTest >> tearDown [ 
	super tearDown.
	morphWindow delete
]
