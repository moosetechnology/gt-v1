Class {
	#name : #GTMetacellerPackageTest,
	#superclass : #GTMetacellerTestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformCommon [
	| package |
	package := ((GTMetacellerConfiguration on: testConfigurationClass) mainProject version: '1.1') package: 'GT-Metaceller-Model'.
	self assert: package platforms size equals: 2. " we also have one for the platform pHaRo ... somehow "
	self assert: (package platforms contains: [ :each | each hasSymbol:#'common' ])
]

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformGemstone [
	| package |
	package := ((GTMetacellerConfiguration on: testConfigurationClass) mainProject version: '1.1') package: 'GlamourCore'.
	self assert: package isNil
]

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformPharo [
	| package |
	package := ((GTMetacellerConfiguration on: testConfigurationClass) mainProject version: '1.1') package: 'GlamourTools'.
	self assert: package platforms size equals: 1.
	self assert: (package platforms includes: (GTPlatformDescription onSymbol: #'pharo'))
]
