Class {
	#name : #GTMetacellerConfigurationTest,
	#superclass : #TestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerConfigurationTest >> testChildren [
	| configuration |
	configuration := GTMetacellerConfiguration on: ConfigurationOfMetaceller.
	self assert: configuration children isEmpty
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testMainProject [
	| configuration |
	configuration := GTMetacellerConfiguration on: ConfigurationOfMetaceller.
	self deny: configuration mainProject hasAttributes
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testProjects [
	| configuration |
	configuration := GTMetacellerConfiguration on: ConfigurationOfMetaceller.
	self assert: configuration projects size equals: 3
]

{ #category : #tests }
GTMetacellerConfigurationTest >> testShortName [
	| configuration |
	configuration := GTMetacellerConfiguration on: ConfigurationOfMetaceller.
	self assert: configuration shortName equals: 'Metaceller'
]
