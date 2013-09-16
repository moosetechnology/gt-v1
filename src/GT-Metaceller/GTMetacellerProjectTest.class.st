Class {
	#name : #GTMetacellerProjectTest,
	#superclass : #TestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerProjectTest >> testCreateVersion [
	| mainProject |
	mainProject := (GTMetacellerConfiguration on: ConfigurationOfMetaceller) mainProject.
	self assert: (mainProject snapshotVersion: '0.2' baseline: '0.1-baseline') equals: 'version02: aSpec
	<version:''0.2'' imports: #( ''0.1-baseline'' )>

	aSpec for: #gemstone do: [
].
	aSpec for: #common do: [
		aSpec package: ''GT-Metaceller'' with: ''GT-Metaceller-DiegoLont.24''].
	aSpec for: #pharo do: [
		aSpec project: ''Glamour'' with: #''stable''].
'
]

{ #category : #tests }
GTMetacellerProjectTest >> testGemstone [
	| project version |
	project := GTMetacellerAtributedProject on: ConfigurationOfMetaceller platform: (GTPlatformDescription onSymbol: #gemstone).
	version := project version: '0.1-baseline'.
	self assert: version packages size equals: 1.
	self assert: version projects size equals: 1
]

{ #category : #tests }
GTMetacellerProjectTest >> testProjects [
	| mainProject |
	mainProject := (GTMetacellerConfiguration on: ConfigurationOfMetaceller) mainProject.
	self assert: mainProject projects size equals: 3
]

{ #category : #tests }
GTMetacellerProjectTest >> testSymbols [
	| mainProject |
	mainProject := (GTMetacellerConfiguration on: ConfigurationOfMetaceller) mainProject.
	self assert: mainProject platformSymbols size equals: 3.
	self assert: (mainProject platformSymbols includes: #'common').
	self assert: (mainProject platformSymbols includes: #'gemstone').
	self assert: (mainProject platformSymbols includes: #'pharo').
]

{ #category : #tests }
GTMetacellerProjectTest >> testVersions [
	| mainProject |
	mainProject := (GTMetacellerConfiguration on: ConfigurationOfMetaceller) mainProject.
	self assert: mainProject versions size equals: 2.
	self assert: (mainProject versions contains: [ :each | each name  ='0.1-baseline' ]).
	self assert: (mainProject versions contains: [ :each | each name ='0.1' ])

]
