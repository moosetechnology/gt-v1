Class {
	#name : #GTMetacellerModelTest,
	#superclass : #GTMetacellerTestCase,
	#instVars : [
		'model'
	],
	#category : #'GT-Metaceller-Tests'
}

{ #category : #setUp }
GTMetacellerModelTest >> createOnSetup [
	^false
]

{ #category : #setUp }
GTMetacellerModelTest >> setUp [
	super setUp.
	model := GTMetacellerModel new
]

{ #category : #tests }
GTMetacellerModelTest >> testCreateClass [
	| currentCount |
	currentCount := model configs size.
	self createTestConfigurationClass.
	self assert: model configs size equals: currentCount +1
]
