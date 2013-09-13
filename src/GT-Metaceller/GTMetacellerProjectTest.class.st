Class {
	#name : #GTMetacellerProjectTest,
	#superclass : #TestCase,
	#category : #'GT-Metaceller-Tests'
}

{ #category : #tests }
GTMetacellerProjectTest >> testGemstone [
	| project version |
	project := GTMetacellerProject on: ConfigurationOfGTMetaceller platform: #gemstone.
	version := project version: '0.1-baseline'.
	self assert: version packages size equals: 1.
	self assert: version projects size equals: 1
]
