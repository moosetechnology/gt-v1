Class {
	#name : #GTMetacellerPackageTest,
	#superclass : #GTMetacellerTestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerPackageTest >> testItemChangeUsingSpec [
	| mainProject item1 item2 |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	item1 := (mainProject version: '1.0-baseline') commonVersion item: 'GT-Metaceller-Streams'.
	item1 saveWithSpecString: 'aSpec
		package: ''GT-Metaceller-Streams'''.
	self assert: item1 requires size equals: 1.
	item1 childVersions do: [ :each |
		self assert: each requires size equals: 1 ].
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	item2 := (mainProject version: '1.0-baseline') commonVersion item: 'GT-Metaceller-Streams'.
	self assert: item2 requires size equals: 0.
	item2 childVersions do: [ :each |
		self assert: each requires size equals: 0 ]
]

{ #category : #tests }
GTMetacellerPackageTest >> testNewPackageUsingSpec [
	| mainProject item |
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	self assert: ((mainProject version: '1.0-baseline') commonVersion item: 'GT-Metaceller-New') isNil.
	((mainProject version: '1.0-baseline') commonVersion item: 'GT-Metaceller-Model')
		saveWithSpecString: 'aSpec
			package: ''GT-Metaceller-New'''.
	mainProject := (GTMetacellerConfiguration on: testConfigurationClass) mainProject.
	item := (mainProject version: '1.0-baseline') commonVersion item: 'GT-Metaceller-New'.
	self assert: item notNil.
	self assert: item requires size equals: 0.
	item childVersions do: [ :each |
		self assert: each requires size equals: 0 ]
]

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformCommon [
	| package |
	package := ((GTMetacellerConfiguration on: testConfigurationClass) version: '1.1') item: 'GT-Metaceller-Model'.
	self assert: package isPackage.
	self assert: package platforms size equals: 2. " we also have one for the platform pHaRo ... somehow "
	self assert: (package platforms contains: [ :each | each hasSymbol:#'common' ])
]

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformGemstone [
	| package |
	package := ((GTMetacellerConfiguration on: testConfigurationClass) version: '1.1') item: 'GlamourCore'.
	self assert: package isNil
]

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformPharo [
	| package |
	package := ((GTMetacellerConfiguration on: testConfigurationClass) version: '1.1') item: 'GlamourTools'.
	self assert: package platforms size equals: 1.
	self assert: (package platforms includes: (GTPlatformDescription onSymbol: #'pharo'))
]
