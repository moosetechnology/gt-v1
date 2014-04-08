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
GTMetacellerProjectTest >> testProjectChangeUsingSpec [
	| gemstoneProject item1 item2 |
	gemstoneProject := (GTMetacellerConfiguration on: testConfigurationClass) projectFor: #'gemstone'.
	item1 := (gemstoneProject version: '1.1') item: 'GlamourCore'.
	self assert: item1 versionString equals: #'development'.
	item1 saveWithSpecString: 'aSpec
		project: ''GlamourCore'' with: #''release1.0'''.
	gemstoneProject := (GTMetacellerConfiguration on: testConfigurationClass) projectFor: #'gemstone'.
	item2 := (gemstoneProject version: '1.1') item: 'GlamourCore'.
	self assert: item2 versionString equals: #'release1.0'.

]

{ #category : #tests }
GTMetacellerProjectTest >> testProjectSpecString [
	| gemstoneProject baselineItem versionItem |
	gemstoneProject := (GTMetacellerConfiguration on: testConfigurationClass) projectFor: #'gemstone'.
	baselineItem := (gemstoneProject version: '1.1-baseline') item: 'GlamourCore'.
	versionItem := (gemstoneProject version: '1.1') item: 'GlamourCore'.
	self assert: baselineItem className equals: 'ConfigurationOfGlamour'.
	self assert: baselineItem versionString equals: #'development'.
	self assert: baselineItem loads equals: #( 'Core' ).
	self assert: baselineItem repositories repositoryDescriptions equals: #( 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ).
	self assert: baselineItem specString equals: 'aSpec
	project: ''GlamourCore'' with: [
		aSpec
			versionString: #''development'';
			className: ''ConfigurationOfGlamour'';
			loads: #( ''Core'');
			repository: ''http://www.smalltalkhub.com/mc/Moose/Glamour/main'' ]'.
	self assert: versionItem className equals: 'ConfigurationOfGlamour'.
	self assert: versionItem versionString equals: #'development'.
	self assert: versionItem loads equals: #( 'Core' ).
	self assert: versionItem repositories repositoryDescriptions equals: #( 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ).
	self assert: versionItem specString equals: 'aSpec
	project: ''GlamourCore'''.

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
