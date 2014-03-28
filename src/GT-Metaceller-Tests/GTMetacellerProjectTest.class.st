Class {
	#name : #GTMetacellerProjectTest,
	#superclass : #GTMetacellerTestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerProjectTest >> testCreateVersion [
	| mainProject |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	(mainProject createSnapshotVersion: '1.2' baseline: '1.1-baseline').
	self assert: (testConfigurationClass includesSelector: #version12:)
]

{ #category : #tests }
GTMetacellerProjectTest >> testGemstone [
	| project version |
	project := (GTMetacellerConfiguration on: testConfigurationClass) projectFor: #gemstone.
	version := project version: '1.1-baseline'.
	self assert: version packages size equals: 3.
	self assert: version projects size equals: 1
]

{ #category : #tests }
GTMetacellerProjectTest >> testProjects [
	| mainProject |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject projects size equals: mainProject platformSymbols size
]

{ #category : #tests }
GTMetacellerProjectTest >> testSymbols [
	| mainProject |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject platformSymbols size equals: 4.
	self assert: (mainProject platformSymbols includes: #'common').
	self assert: (mainProject platformSymbols includes: #'gemstone').
	self assert: (mainProject platformSymbols includes: #'pharo').
	self assert: (mainProject platformSymbols includes: #'pHaRo').
]

{ #category : #tests }
GTMetacellerProjectTest >> testVersions [
	| mainProject |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject versions size equals: 4.
	self assert: (mainProject versions contains: [ :each | each versionName  ='1.1-baseline' ]).
	self assert: (mainProject versions contains: [ :each | each versionName ='1.1' ]).
	self assert: (mainProject version: '1.1-baseline') packagesAndProjects size equals: 8

]
