Class {
	#name : #GTToolkitExampleTestCase,
	#superclass : #GTExampleTestCase,
	#category : #'GT-Tests-Examples'
}

{ #category : #running }
GTToolkitExampleTestCase >> setUp [
	super setUp.
	
	GTExampleOrganizer reset; stop
]

{ #category : #running }
GTToolkitExampleTestCase >> tearDown [
	super tearDown.
	
	GTExampleOrganizer reset; start
]

{ #category : #tests }
GTToolkitExampleTestCase >> testExamplesDebugger [
	self runExampleContainers: (self packages: { 'GT-Debugger*' })
]

{ #category : #tests }
GTToolkitExampleTestCase >> testExamplesInspector [
	self runExampleContainers: (self packages: { 'GT-Inspector*' })
]

{ #category : #tests }
GTToolkitExampleTestCase >> testExamplesPlayground [
	self runExampleContainers: (self packages: { 'GT-Playground*' })
]

{ #category : #tests }
GTToolkitExampleTestCase >> testExamplesSpotter [
	self runExampleContainers: (self packages: { 'GT-Spotter*' })
]
