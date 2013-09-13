Class {
	#name : #GTMetacellerConfigurationTest,
	#superclass : #TestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerConfigurationTest >> testChildren [
	| configuration |
	configuration := GTMetacellerConfiguration on: ConfigurationOfGTMetaceller.
	self assert: configuration children isEmpty
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testMainProject [
	| configuration |
	configuration := GTMetacellerConfiguration on: ConfigurationOfGTMetaceller.
	self assert: configuration mainProject platform equals: nil
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testProjects [
	| configuration |
	configuration := GTMetacellerConfiguration on: ConfigurationOfGTMetaceller.
	self assert: configuration projects size equals: GTMetacelloProject platforms size
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testShortName [
	| configuration |
	configuration := GTMetacellerConfiguration on: ConfigurationOfGTMetaceller.
	self assert: configuration shortName equals: 'GTMetaceller'
]
