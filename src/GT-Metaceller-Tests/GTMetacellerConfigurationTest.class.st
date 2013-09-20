Class {
	#name : #GTMetacellerConfigurationTest,
	#superclass : #GTMetacellerTestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerConfigurationTest >> testChildren [
	| configuration |
	configuration := GTMetacellerConfiguration on: testConfigurationClass.
	self assert: configuration children isEmpty
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testMainProject [
	| configuration |
	configuration := GTMetacellerConfiguration on: testConfigurationClass.
	self deny: configuration mainProject hasAttributes
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testProjects [
	| configuration |
	configuration := GTMetacellerConfiguration on: testConfigurationClass.
	self assert: configuration projects size equals: 3
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testShortName [
	| configuration |
	configuration := GTMetacellerConfiguration on: testConfigurationClass.
	self assert: configuration shortName equals: 'TestForMetaceller'
]
