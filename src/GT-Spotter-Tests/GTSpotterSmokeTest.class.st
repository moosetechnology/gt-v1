Class {
	#name : #GTSpotterSmokeTest,
	#superclass : #TestCase,
	#instVars : [
		'window'
	],
	#category : #'GT-Spotter-Tests'
}

{ #category : #running }
GTSpotterSmokeTest >> setUp [
	super setUp.
	
	
]

{ #category : #'as yet unclassified' }
GTSpotterSmokeTest >> tearDown [
	super tearDown.
	
	window ifNotNil: [ window delete ]
]

{ #category : #tests }
GTSpotterSmokeTest >> testOpen [

	window := (GTSpotterMorph new spotterModel: GTSpotter new; showPreview; yourself) extent: 500@500; openInWorld.
]
