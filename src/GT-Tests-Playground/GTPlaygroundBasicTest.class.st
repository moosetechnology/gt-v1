Class {
	#name : #GTPlaygroundBasicTest,
	#superclass : #TestCase,
	#instVars : [
		'playground',
		'window'
	],
	#category : #'GT-Tests-Playground'
}

{ #category : #running }
GTPlaygroundBasicTest >> setUp [

	playground := GTPlayground new.
]

{ #category : #running }
GTPlaygroundBasicTest >> tearDown [

	window ifNotNil: [ window delete ]
]

{ #category : #running }
GTPlaygroundBasicTest >> testSettingBindings [
	|obtainedResult|
	obtainedResult:=nil.
	window := playground openOn: (GTPlayPage new content: 'number+1').
	playground 
		setBindings: { #number -> 2 } asDictionary.
	playground inspectorPresentation firstPresentation selectLine.
	
	playground inspectorPresentation firstPresentation announce: (GLMEvaluateSelection new 
		action: [ :aResult | obtainedResult := aResult ];
		makeSyncronous).
		
	self assert: obtainedResult equals: 3
	
]
