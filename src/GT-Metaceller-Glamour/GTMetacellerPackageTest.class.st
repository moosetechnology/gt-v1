Class {
	#name : #GTMetacellerPackageTest,
	#superclass : #TestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformCommon [
	| package |
	package := ((GTMetacellerConfiguration on: ConfigurationOfMetaceller) mainProject version: '0.1') package: 'GT-Metaceller-Model'.
	self assert: package platforms size equals: 1.
	self assert: (package platforms contains: [ :each | each hasSymbol:#'common' ])
]

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformGemstone [
	| package |
	package := ((GTMetacellerConfiguration on: ConfigurationOfMetaceller) mainProject version: '0.1') package: 'GlamourCore'.
	self assert: package isNil
]

{ #category : #tests }
GTMetacellerPackageTest >> testPlatformPharo [
	| package |
	package := ((GTMetacellerConfiguration on: ConfigurationOfMetaceller) mainProject version: '0.1') package: 'GlamourAll'.
	self assert: package platforms size equals: 1.
	self assert: (package platforms includes: (GTPlatformDescription onSymbol: #'pharo'))
]
