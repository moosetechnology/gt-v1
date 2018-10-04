Class {
	#name : #GTToolkitExamplesTests,
	#superclass : #GTExampleTestCase,
	#category : #'GT-Tests-Examples'
}

{ #category : #running }
GTToolkitExamplesTests >> setUp [
	super setUp.
	
	GTExampleOrganizer reset; stop
]

{ #category : #running }
GTToolkitExamplesTests >> tearDown [
	super tearDown.
	
	GTExampleOrganizer reset; start
]

{ #category : #tests }
GTToolkitExamplesTests >> testExamplesDebugger [
	self runExampleContainers: (self packages: { 'GT-Debugger*' })
]

{ #category : #tests }
GTToolkitExamplesTests >> testExamplesInspector [
	self runExampleContainers: (self packages: { 'GT-Inspector*' })
]

{ #category : #tests }
GTToolkitExamplesTests >> testExamplesPlayground [
	self runExampleContainers: (self packages: { 'GT-Playground*' })
]

{ #category : #tests }
GTToolkitExamplesTests >> testExamplesSpotter [
	self runExampleContainers: (self packages: { 'GT-Spotter*' })
]
