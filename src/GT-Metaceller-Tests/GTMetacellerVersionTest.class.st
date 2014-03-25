Class {
	#name : #GTMetacellerVersionTest,
	#superclass : #GTMetacellerTestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #asserting }
GTMetacellerVersionTest >> assertItem: anItem equals: anItem2 [
	self assert: anItem class equals: anItem2 class.
	self assert: anItem itemName equals: anItem2 itemName
]

{ #category : #asserting }
GTMetacellerVersionTest >> assertVersion: aVersion equals: aVersion2 [
	self assert: aVersion packagesAndProjects size equals: aVersion2 packagesAndProjects size.
	aVersion packagesAndProjects do: [ :each |
		self assertItem: each equals: (aVersion2 itemFor: each itemName) ].
	self assert: aVersion category equals: aVersion2 category.
	self assert: aVersion repositoriesToWrite equals: aVersion2 repositoriesToWrite
]

{ #category : #asserting }
GTMetacellerVersionTest >> denyEmptySpecIn: aMethodString [
	| index |
	index := (aMethodString findString: 'aSpec') + 5.
	[ index > 5 ] whileTrue: [
		self assert: (aMethodString findString: ';' startingAt: index) > 0.
		self assert: (aMethodString findString: 'yourself' startingAt: index) > (aMethodString findString: ';' startingAt: index).
		index := (aMethodString findString: 'aSpec' startingAt: index) +5 ]
]

{ #category : #tests }
GTMetacellerVersionTest >> testBaselineCopy [
	| mainProject version1 version2 |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	version1 := mainProject version:'0.1-baseline'.
	version1 saveAs: '0.2-baseline'.
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject versions size equals: 3.
	self assert: (mainProject versions contains: [ :each | each name ='0.2-baseline' ]).
	version2 := mainProject version: '0.2-baseline'.
	self assertVersion: version1 equals: version2
]

{ #category : #tests }
GTMetacellerVersionTest >> testBaselineGemstoneCopy [
	| config version gemstoneVersion1 gemstoneVersion2 |
	config := (GTMetacellerConfiguration on: testConfigurationClass).
	version := config mainProject version:'0.1-baseline'.
	gemstoneVersion1 := (config projectFor: #gemstone) version:'0.1-baseline'.
	version saveAs: '0.2-baseline'.
	config := (GTMetacellerConfiguration on: testConfigurationClass).
	gemstoneVersion2 := (config projectFor: #gemstone) version:'0.2-baseline'.
	self assertVersion: gemstoneVersion1 equals: gemstoneVersion2
]

{ #category : #tests }
GTMetacellerVersionTest >> testVersionCopy [
	| mainProject version1 version2 |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	version1 := mainProject version: '0.1'.
	version1 saveAs: '0.2'.
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject versions size equals: 3.
	self assert: (mainProject versions contains: [ :each | each name ='0.2' ]).
	version2 := mainProject version: '0.2'.
	self assert: version2 packagesAndProjects size equals: version1 packagesAndProjects size.
	self assert: version2 category equals: version1 category.
	self deny: (version2 methodString includesSubstring: '#''pharo''').
	self deny: (version2 methodString includesSubstring: '#''gemstone''').
	self denyEmptySpecIn: version2 methodString

]
