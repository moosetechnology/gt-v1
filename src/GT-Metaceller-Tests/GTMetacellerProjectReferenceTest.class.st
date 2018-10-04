Class {
	#name : #GTMetacellerProjectReferenceTest,
	#superclass : #GTMetacellerTestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerProjectReferenceTest >> testProperties [
	| item |
	item := ((GTMetacellerConfiguration on: testConfigurationClass) version: '1.1') item: 'GlamourTools'.
	self assert: item isProject.
	self assert: item className equals: 'ConfigurationOfGToolkit'
]
