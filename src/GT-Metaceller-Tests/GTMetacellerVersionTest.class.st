Class {
	#name : #GTMetacellerVersionTest,
	#superclass : #GTMetacellerTestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #asserting }
GTMetacellerVersionTest >> assertCleanVersion: aMethodString [
	self assert: (aMethodString findString: 'file:') equals: 0.
	self assert: (aMethodString findString: 'repository:') equals: 0
]

{ #category : #asserting }
GTMetacellerVersionTest >> assertItem: anItem equals: anItem2 [
	self assert: anItem class equals: anItem2 class.
	self assert: anItem itemName equals: anItem2 itemName.
	self assert: anItem requires equals: anItem2 requires.
	anItem isProject ifTrue: [ 
		self assert: anItem className = anItem2 className ]
]

{ #category : #asserting }
GTMetacellerVersionTest >> assertVersion: aVersion equals: aVersion2 [
	self assert: aVersion items size equals: aVersion2 items size.
	aVersion items do: [ :each |
		self assertItem: each equals: (aVersion2 item: each itemName) ].
	self assert: aVersion category equals: aVersion2 category.
	self assert: aVersion repositoriesToWrite equals: aVersion2 repositoriesToWrite
]

{ #category : #asserting }
GTMetacellerVersionTest >> denyEmptySpecIn: aMethodString [
	self assert: (aMethodString findString: 'yourself') equals: 0
]

{ #category : #tests }
GTMetacellerVersionTest >> testBaselineCopy [
	| mainProject version1 version2 oldSize |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	oldSize := mainProject versions size.
	version1 := mainProject version:'1.1-baseline'.
	version1 saveAs: '1.2-baseline'.
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject versions size equals: oldSize +1.
	self assert: (mainProject versions contains: [ :each | each versionName ='1.2-baseline' ]).
	version2 := mainProject version: '1.2-baseline'.
	self assertVersion: version1 equals: version2
]

{ #category : #tests }
GTMetacellerVersionTest >> testBaselineGemstoneCopy [
	| config version gemstoneVersion1 gemstoneVersion2 |
	config := (GTMetacellerConfiguration on: testConfigurationClass).
	version := config mainProject version:'1.1-baseline'.
	gemstoneVersion1 := (config projectFor: #gemstone) version:'1.1-baseline'.
	version saveAs: '1.2-baseline'.
	config := (GTMetacellerConfiguration on: testConfigurationClass).
	gemstoneVersion2 := (config projectFor: #gemstone) version:'1.2-baseline'.
	self assertVersion: gemstoneVersion1 equals: gemstoneVersion2
]

{ #category : #tests }
GTMetacellerVersionTest >> testVersionCopy [
	| mainProject version1 version2 oldSize |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	oldSize := mainProject versions size.
	version1 := mainProject version: '1.1'.
	version1 saveAs: '1.2'.
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject versions size equals: oldSize +1.
	self assert: (mainProject versions contains: [ :each | each versionName ='1.2' ]).
	version2 := mainProject version: '1.2'.
	self assertVersion: version2 equals: version1.
	self deny: (version2 methodString includesSubstring: '''repository''').
	self deny: (version2 methodString includesSubstring: '#''pharo''').
	self deny: (version2 methodString includesSubstring: '#''gemstone''').
	self denyEmptySpecIn: version2 methodString

]

{ #category : #tests }
GTMetacellerVersionTest >> testVersionCopyUsingSpec [
	| mainProject version1 version2 oldSize |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	oldSize := mainProject versions size.
	version1 := mainProject version: '1.0'.
	version1 commonVersion saveWithSpecString: 'version101: aSpec
	<version: ''1.0.1'' imports:#( ''1.0-baseline'' )>
	aSpec
		description: ''A changed description'';
		yourself'.
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject versions size equals: oldSize +1.
	self assert: (mainProject versions contains: [ :each | each versionName ='1.0.1' ]).
	version2 := mainProject version: '1.0.1'.
	self assertVersion: version2 equals: version1.
	self deny: (version2 methodString includesSubstring: '#''pharo''').
	self assert: (version2 methodString includesSubstring: '#''gemstone''').
	self denyEmptySpecIn: version2 methodString.
	self assertCleanVersion: version2 methodString.
	self assert: version2 description equals: 'A changed description'.
	self assert: version2 blessing equals: #'development'.
	self assert: version2 author equals: Author fullName.
	self assert: version2 timestamp equals: DateAndTime now asDate yyyymmdd
]

{ #category : #tests }
GTMetacellerVersionTest >> testVersionCopyWithVersions [
	| mainProject version1 version2 oldSize |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	oldSize := mainProject versions size.
	version1 := mainProject version: '1.0'.
	version1 saveAs: '1.0.1'.
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: mainProject versions size equals: oldSize +1.
	self assert: (mainProject versions contains: [ :each | each versionName ='1.0.1' ]).
	version2 := mainProject version: '1.0.1'.
	self assertVersion: version2 equals: version1.
	self deny: (version2 methodString includesSubstring: '#''pharo''').
	self assert: (version2 methodString includesSubstring: '#''gemstone''').
	self denyEmptySpecIn: version2 methodString

]
